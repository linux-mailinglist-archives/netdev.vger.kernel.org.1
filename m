Return-Path: <netdev+bounces-225726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A604B97917
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 23:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 09F7A4E117E
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 21:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D7D30C605;
	Tue, 23 Sep 2025 21:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bPqx9QOL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8FA265CBD
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 21:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758662814; cv=none; b=GVB4dXmjc5gcJbPyin3EIl2k+7r1vwo3bp+wXJgzOAjZQ2NQNTcHOV5cJWx7DKjQWDcoX8bp8KJHyZA6uZtIxJa/xn6pN6J1jwTJu38YK4BEpIpvBxtiFFDZ/1yENhxVCVqCvgTUAdj+IT5PR7fFmqaEoLkpQ4fJDQRNDemR/AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758662814; c=relaxed/simple;
	bh=98TTorsAAC5opB5uJTgkfC0e3/EFtVZUCwE9L5IqI5I=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=eYBIH28JuM65fqgii3/GieA4KOt4cVpC+cSpPwb1p+uPEJqK4ihIPA4Ko+fYdVDr3OdhdR7PFf2wCHImy9jsdqYtGR5B7XloP6LWTCITTeVikOenr84Vm+//IprXKQxzcOc6WR1olfkE5UZchHVym+kw+BoXi8S9mh1UariKXqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bPqx9QOL; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-80b7a6b2b47so547741685a.0
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 14:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758662812; x=1759267612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TzM+YAdlSU/VZW+2Cq6jx12e0U5MbjPEMSsvWJfPo/o=;
        b=bPqx9QOLaXpHPp/Dh+Cr2IIHQwxDWy9cz3qqhQrTNIVFgpCdukzDGxr0xsWJD9LzHY
         Sj0yoM0n5gO/MCCI5P7407/MK48qklBQA/b7cQ2mRmKJG7hQwLArXF+jv4PHGVkyFQ7M
         kQJMwJLxoiJF1aKRKcgsobGMN0G6YZpviIdCTh0H6rwwETnOnJwS3tIXUbWn7BEj9GBY
         SavlvAPJxqN0G+ms0g4Wx602Df0noXwF+9JYRLe3/otPKrA6/SpyB0f6T5sZsyBkRBi0
         Ajssx+uiwYP0VOwYmTtYHN9XH+DyNithD9uXF8vhmF/GYxZeRjz6/zrKoBdAxZD0W7ep
         sF7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758662812; x=1759267612;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TzM+YAdlSU/VZW+2Cq6jx12e0U5MbjPEMSsvWJfPo/o=;
        b=YAJKLcNqfApQKRNKDiuuLVb0xvuYqjPZsTTfLHewbS++p2gT6Oq1r93A2tj2yt246H
         LR7KAxz8S/Svt1IZb5mAXT8IL3RU01ivGyBDJ0dJ8k5qFHJvOQw7Q3jpKcV0HBxSQ9Xg
         6mWtXmvkJGe0ZVnic2tdkG02eiub6Y0vPpaAyJEvgSf/uy9aMimUnKEl8uz9Ietu/4uo
         wE+wFCMzb5Ndm5LOvgBPROLX44N0xOLw3SMVzFCIQAcD4fFqECE5lBmVtwqbrfY2ZAM7
         d1zD6jRilseB/zOs36AmOilMiBB19YPQouBmCl9UlNpCohZlrS1WrKHIo5R5JXe/ZQVy
         lj6g==
X-Forwarded-Encrypted: i=1; AJvYcCXnm/VeKUKuZM79I55NzF1h5QR8pQl6CLiPmZne5mXZ6+3dDQqpQw/8PfJnG+YeqzVwoCRnEl4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFLXijpz/TMBjk2Db/G2ME80RdjfoVzip2MDYKcRJEfLB7dEZm
	lBW8jTai0hosXLqryevJe2MgS2fQSSv0QrLVUdVZV6jUUzzREdWgsfnz5DG3Bw==
X-Gm-Gg: ASbGnctJbB+gutMG8faLKpT0x5wYZlm+Ja7axo2GklPCX3UMP+ixexibvPaMQydoRCK
	qlE2WkUkQvzb9geSZ+sL1yMLpfmAfTpFkHdGSiT4Yd4HNiT7hKZybpZl+B0b3WuY+wdFtl87Ntr
	6NxgNarRk2mJnMgp+kWrXWm4Z26vASCF1B7NcTPLfKi5kMmYEVXqAjs8cUKD3zUMUT7sjCL0rBy
	ZpZro39NnD7KWBeBdlbuZbCNe138Ozb+mw7MxRERY6W8r4WrwZOZEvNn2xiNZi936XcdtBFeYvv
	kiZSd7stvDb17sLkMxg3RkHCMEVQevGFxQ4xz3hnEiRQkETQ3tak6jqPz7ozgcs+yFmfdYEqe24
	Y6A0vIq0S/lZWDGUSAT9FpKA4FqOuYkycCn2XL61t69F4zqNtW64gk9V25xbdDHk6+k4PQg==
X-Google-Smtp-Source: AGHT+IH8atUv4YKSIxfZVb6zK7i1Ycf2XPhQsuhnYzuHVn6FuO+wM4OiWHH3TWoKcLdGgcHi4O5NpA==
X-Received: by 2002:a05:620a:1a8d:b0:83b:d570:acba with SMTP id af79cd13be357-8516aa0ddcamr431669185a.29.1758662812136;
        Tue, 23 Sep 2025 14:26:52 -0700 (PDT)
Received: from gmail.com (21.33.48.34.bc.googleusercontent.com. [34.48.33.21])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-83630481f38sm1039458585a.39.2025.09.23.14.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 14:26:51 -0700 (PDT)
Date: Tue, 23 Sep 2025 17:26:50 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Richard Gobert <richardbgobert@gmail.com>, 
 netdev@vger.kernel.org, 
 pabeni@redhat.com, 
 ecree.xilinx@gmail.com, 
 willemdebruijn.kernel@gmail.com
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 horms@kernel.org, 
 corbet@lwn.net, 
 saeedm@nvidia.com, 
 tariqt@nvidia.com, 
 mbloch@nvidia.com, 
 leon@kernel.org, 
 dsahern@kernel.org, 
 ncardwell@google.com, 
 kuniyu@google.com, 
 shuah@kernel.org, 
 sdf@fomichev.me, 
 aleksander.lobakin@intel.com, 
 florian.fainelli@broadcom.com, 
 alexander.duyck@gmail.com, 
 linux-kernel@vger.kernel.org, 
 linux-net-drivers@amd.com, 
 Richard Gobert <richardbgobert@gmail.com>
Message-ID: <willemdebruijn.kernel.2d533675f308@gmail.com>
In-Reply-To: <20250923085908.4687-4-richardbgobert@gmail.com>
References: <20250923085908.4687-1-richardbgobert@gmail.com>
 <20250923085908.4687-4-richardbgobert@gmail.com>
Subject: Re: [PATCH net-next v8 3/5] net: gso: restore ids of outer ip headers
 correctly
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Richard Gobert wrote:
> Currently, NETIF_F_TSO_MANGLEID indicates that the inner-most ID can
> be mangled. Outer IDs can always be mangled.
> 
> Make GSO preserve outer IDs by default, with NETIF_F_TSO_MANGLEID allowing
> both inner and outer IDs to be mangled.
> 
> This commit also modifies a few drivers that use SKB_GSO_FIXEDID directly.
> 
> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
> Reviewed-by: Edward Cree <ecree.xilinx@gmail.com> # for sfc

Reviewed-by: Willem de Bruijn <willemb@google.com>

Thanks for added the pointer to segmentation-offloads.rst.

