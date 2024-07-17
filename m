Return-Path: <netdev+bounces-111831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3861D933578
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 04:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD961B225F9
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 02:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2062582;
	Wed, 17 Jul 2024 02:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="ZiVWw67x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DCB8BF3
	for <netdev@vger.kernel.org>; Wed, 17 Jul 2024 02:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721183710; cv=none; b=NAkxUyB6sksKrxN27NAgK42GxVAqhHrCod+7A8O/sBdjYis117inkCBC+60Ra1DekV7Etl+YYHH7LMgkTx+qjjySZ7d8lPLVbdaqJr1q//sY1RidZwaX/uNT+NxmEw/MFQPw6CsFC/p+h0Z6sRWjIcFSOjkqnbuGfsSe9UOy6oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721183710; c=relaxed/simple;
	bh=+mPloI3NJFqgI7gIr0FyguxSR4TOA6+nSYx4+8Y8ufo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fXCJBmcdtNJEheUtpov63Cc2QPGp0IFB1dJLWXgV442wxW4j5G15O4yohc92zDi751sIMMbr9yrC3nIYnnZBwxf4EM3o8Gm3srPEZF57YRVRVaSCP/653zbLccU5DmHZlZJQyn9hWi1dpzYucHns7SEzxZvRD2fLSWUHsNkSxy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=ZiVWw67x; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fc424901dbso9376225ad.1
        for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 19:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1721183708; x=1721788508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gfiaKrBRbt8oifurmVTCv4pQ1rT+X17+wSovzmfvATE=;
        b=ZiVWw67xRvjaoQLY9czUEhbMHZKC2bzveEwBnHixdwjj0370cFxnmgQcBm3gZTjC0B
         noRRTNsqlaDssBjkG0/gA6OPkK4H5IG0lqj7STFbthrDRSun+EtxPjjipZ3gPQ1mtS03
         pDEFd2F6y+JmHKLn/4fEIOdcOFt0qf/NxKNxYKX2+LnpxhR9GvTl6os2cDN+bQ7+ZoBk
         E5L4jBvSQlyagxqW+4k+BEJ8V1+fqnlv4DNxUFaBcLGjd/7C6pHGjHAnvngvlxwzrTOv
         YGctjf4OK9q9bvM49oDDzDzOPWCN+TsA/sc8tJ6R4jS4tNxnDgCtnfJ2Ia6emQNpEa4x
         2I6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721183708; x=1721788508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gfiaKrBRbt8oifurmVTCv4pQ1rT+X17+wSovzmfvATE=;
        b=LdRBVBD3GCmIYJMNBCGhLhwO3hPVdMjVsNUoh3bAf6yebDG09PLu/BZBDdeXcxZWE+
         gI/oSqfWMjs475LNvuOzOhnQaswjvAuiw6WoEw9vJVrT2yzkTqtaq0eH/OYllmnH+Iyn
         hNR3OeLAm2978GvZKavLLJlOV/WBH408JQA3CkJKM7/JX74OHxM3lR3r6QsuJCK03E+U
         8MRPcZQAcQ4GLlAhXnlkNWWhAE2fiAxOPH6aqkapHkTRO5aBOi5LDr8GemBiZ71jMYV9
         5sWFQMYXnlUMoYGJR+6XH2ipt5qFZtvu09jcSoyDKYrnlzwZ1U0/4vPQCARph5WNOC9Q
         lqjQ==
X-Gm-Message-State: AOJu0Yz+N7nz5Elvh9r7WL0DDYMBJhrsIE2NJaIzCeRHw73w0DjfTb+f
	LJVpsVzzM7ylgLS9NEV2rPiOASSCUZF87cuQBxuLC89we+OFi7J6ro0U5G1ulPc=
X-Google-Smtp-Source: AGHT+IFOq/oRYluyCq7TJzxS6qCXVvaVNRje8pOukX4Nyi3UGMbWfkUWeSHbGGpGffp26V3DsHJ7Cg==
X-Received: by 2002:a17:902:ced2:b0:1fb:5a7a:2764 with SMTP id d9443c01a7336-1fc4e66994dmr2226485ad.37.1721183707658;
        Tue, 16 Jul 2024 19:35:07 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc46562sm65625125ad.253.2024.07.16.19.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 19:35:07 -0700 (PDT)
Date: Tue, 16 Jul 2024 19:35:05 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH net-next] net: drop special comment style
Message-ID: <20240716193505.2f553fa8@hermes.local>
In-Reply-To: <20240716134822.028c84bbd92f.Ic187fbc5ba452463ef28feebbd5c18668adb0fec@changeid>
References: <20240716134822.028c84bbd92f.Ic187fbc5ba452463ef28feebbd5c18668adb0fec@changeid>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Jul 2024 13:48:23 -0700
Johannes Berg <johannes@sipsolutions.net> wrote:

> From: Johannes Berg <johannes.berg@intel.com>
> 
> As we just discussed (in the room at netdevconf), drop the
> requirement for special comment style for netdev.
> 
> For checkpatch, the general check accepts both right now,
> so simply drop the special request there as well.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Agree, the less special cases the better.

Acked-by: Stephen Hemminger <stephen@networkplumber.org>

