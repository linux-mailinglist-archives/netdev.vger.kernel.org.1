Return-Path: <netdev+bounces-48499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1557EE9DC
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 00:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C1DAB20A5E
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 23:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56F52FE32;
	Thu, 16 Nov 2023 23:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="pIx3QkiM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22CEFD6B
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 15:05:24 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1cc4f777ab9so12664235ad.0
        for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 15:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1700175923; x=1700780723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NgTG16StPX9pI10P7y/9FCGW5EKxtmwFFqHv5aTtJJ4=;
        b=pIx3QkiMePUYQrOmfKFCjRUrR4rPKKlqNzxbrYO0YOcHuszyPvq4xmwI4kgwBt2fKP
         NAhOlpG/Ahlrc8Lo2xQAsSIX8MD+B+fLHizU6PTbdjV9bf1NrNngwy6xaIN9AWM2JcUz
         CV9uk7CZXyKA+duznp5wLecImzjqLSWHUP+7FsD1/nfbgDWT1apzYXh23bXfuqYhH9U+
         cZh6UAfNnDhrPlTokqXmYM6ylxjhjeaJUcE5QAnvnznapBeef8+L+g3Uo2W+sbnF9xkp
         DAWr4M+JDfmJxTd06QRHlmdZeq7PGjpWeAl8y8fWwPYF4rcwRg6aRK/8oUsrGpmAFEJV
         8cVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700175923; x=1700780723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NgTG16StPX9pI10P7y/9FCGW5EKxtmwFFqHv5aTtJJ4=;
        b=PVYvrGYp6WZ3QMpcsPtxCx4KadpQBvqxKPprNOGtAoHu71HXXL45+rKYAx+ijIR6hS
         0g1eCcPBnNK/1p/XKX6Bmb5dmGeYTJjBNJ2cjYByjCy8++Pp7k0Uru7aTTLSzF5tUDrZ
         28rhy9Hd47mNpkfzvTteSfhgRYIKZu/50TIUKOUH0slPWvk7riZomTNhtip3Fpd01yJp
         nlb/9zSw0NXf3f6il66OQ7Iekj4dJHwN3/6ReZBgBUwfdGNKVKlD8EzSBTZBSaIpilal
         4efv2HSPvnkovibGpS+jP+cWU92qqCb9j96drxNN8efi3WjgvvkWlpuAvRGQOkIw0clv
         0AtQ==
X-Gm-Message-State: AOJu0Yym377tX32K87gYBzUjMz8PIkkCWOejdwJHfr9Ys5E4aqukDhF7
	Q6mpON3Ue2fFDA3NwiKXJ+FuqQ==
X-Google-Smtp-Source: AGHT+IEFqcutImAl7hJYmnCfmUwMDCDXrJ9PYmxXmjo2uYOxFNX+ybIQaxblTm70ZQqUKILMhdm0JA==
X-Received: by 2002:a17:902:bf02:b0:1cc:45db:e21e with SMTP id bi2-20020a170902bf0200b001cc45dbe21emr9662778plb.37.1700175923537;
        Thu, 16 Nov 2023 15:05:23 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id g24-20020a1709029f9800b001b89466a5f4sm186656plq.105.2023.11.16.15.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 15:05:23 -0800 (PST)
Date: Thu, 16 Nov 2023 15:05:21 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: heminhong <heminhong@kylinos.cn>
Cc: petrm@nvidia.com, netdev@vger.kernel.org
Subject: Re: [PATCH v4] iproute2: prevent memory leak
Message-ID: <20231116150521.66a8ea69@hermes.local>
In-Reply-To: <20231116031308.16519-1-heminhong@kylinos.cn>
References: <87y1ezwbk8.fsf@nvidia.com>
	<20231116031308.16519-1-heminhong@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 Nov 2023 11:13:08 +0800
heminhong <heminhong@kylinos.cn> wrote:

> When the return value of rtnl_talk() is not less than 0,
> 'answer' will be allocated. The 'answer' should be free
> after using, otherwise it will cause memory leak.
> 
> Signed-off-by: heminhong <heminhong@kylinos.cn>

I am skeptical, what is the code path through rtn_talk() that
returns non zero, and allocates answer.  If so, that should be fixed
there.

In current code, the returns are:
	- sendmsg() fails
	- recvmsg() fails
	- truncated message
	
The paths that set answer are returning 0

