Return-Path: <netdev+bounces-148711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 031FA9E2F3D
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 23:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46061B27220
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 22:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A121E0B62;
	Tue,  3 Dec 2024 22:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VCMlXgfk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D7F1D8E1E
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 22:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733265344; cv=none; b=MLyOY9VMue05MhDn/a3Ij82UbBPtyh7sO3V91YHlBbq+7oelbRmOSCKA/Fl53lNI6d92avJ5xtO/bSpMQmvyW3gdUXslaUzi0dtDmGEw0ilfhNqVMcXTALSpR/Ns2Vg71xCoSedHhhS/hXd5CLfme4fvR4+oxqzNd6ZowFj4mvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733265344; c=relaxed/simple;
	bh=kYViiozP3wXER1FMTLl7y1IjqZskGkRhdRjZE2MHPeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OcnvSQDeoth3QLouzLJVjtJB1iwSru0tYVzzG6ARz5JLNKRwPuqgHWo+ph9pMEeadNlMNkl7S7TVlb3PQF93rFp4bHlp1ol60yjnkh5VxLN2MfHwFxwkwkqHffywvqtIXGc9lpux9R0gaxjy2mHZjpLC6e3esRhjFGy+tIeXXzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VCMlXgfk; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7256dc42176so3015574b3a.3
        for <netdev@vger.kernel.org>; Tue, 03 Dec 2024 14:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733265342; x=1733870142; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=loBDMJH2zBR8LxlFbyL9wElqOG056//EhC4OoIsws6g=;
        b=VCMlXgfkk1qfcC0+NOMOw80dLsUcNKuhY2vJ6UPR8nbYK2dlAT2Fh+cSJzhz1TZMY7
         cSFQhh6zHCjnR70gS6OOY6Hbl5cm8zQ6Wkk1nxtsyM6bZL+OvfzSirAw/zfkiG0EBR0E
         Z5Y6xhH5shMgicdvwSoaf4OZfjvN24RpbP2Ny788Y3CLZRjTMIpzVoQ2QvxX/+VCGQuM
         2r3mTIqd6JaVITpJ6PP6AWTkxaqJVSXTvSgV/2Jd3ZHJ9+Tc5BrKNQTPgMAIN01oqxg3
         Obt3kzThyZ9bdOAo+eGTPLq+B3AjxjUdIGMLD3wYxPFKn5CKZJqAK4rFT60YhN8hCtJZ
         4m9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733265342; x=1733870142;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=loBDMJH2zBR8LxlFbyL9wElqOG056//EhC4OoIsws6g=;
        b=GBYRxfuol0jnmgpZ8j+8FKVXEjKmPAlzWoQ0Wvi/lrqFDW7MWdD7D/Ilclkuw0+Kuk
         Gc7SOEQetSq0lMECyu5BwokPHbKY7dKYZXJy4XvlGdqcccUucLLlSM9iyK++7T21HOYg
         +TvrW6hqvRUGWaGM1lm3VlH6/myDtGKLd8xbH5FHqEV4G0lWCm1sXYCWPEtE+wPOAY3j
         stNX9+FM0DD6MOUZ2NwQDzdV8GYCktbPlMILSAvuv9DKgP5Gb0s9Sd+XACDr+iqtcLHY
         31s12Q2axuZJbl6n+x13yJSmZkJaolV0ZRCoja79tGLnfOasYL9W+fUKLCf3SJMIqFPd
         sQVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjOZScMTxri2bFJTl5Kyu+vqpL7FW2N+XMLUtB0p2Ux6Kdp/rglx5bvJzRW9haIBizG3oIIAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YynLvFYiTT2h8DwXuCFt/v7nEwzWsBsX25cnSVU0FIzTWB9ZxaD
	guxrJ9kDscGU66czljjBwl69THdASTK6g1eMHwUwr9Mqg5NH8Hm9
X-Gm-Gg: ASbGncs7Wq78v5UxISMLaJhn7O1O4aRxut0XcTaRMnZYQse8TPJVE8HEyS8I5zckzIl
	GCbmWyT/yRVqJUgITmyATR6XLFZp1ipaEuEbL09zA1DD54Y5Y8WBO+yCiyM0jjiRe1YIe6rh0rk
	5j2ynY/p7H8fFpYC8DLzr8+5QpdQFfXVSzxFfZ7BSgg30NEB2wcQFHZ9uIaP8q/ciKdcXyykdh7
	VbwJe/3yJg+oCrwD5SVunCDCk8I5OhdM+1hk+vEBjqOKcYGjdenHtUSbU2pxj+JmWs72f8j4kne
	xEyDnTN3
X-Google-Smtp-Source: AGHT+IH8BuwEdeBixD/Zw52WI1Q/MXZtqz2OJHZ1fIPnvP21ppGiNMP3R+n0L/WDaHfUFsuizY3nXQ==
X-Received: by 2002:a17:902:f684:b0:215:96bc:b680 with SMTP id d9443c01a7336-215bd16f544mr60325935ad.42.1733265342321;
        Tue, 03 Dec 2024 14:35:42 -0800 (PST)
Received: from xiberoa (c-76-103-20-67.hsd1.ca.comcast.net. [76.103.20.67])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2156b1601basm59404425ad.196.2024.12.03.14.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 14:35:40 -0800 (PST)
Date: Tue, 3 Dec 2024 14:35:38 -0800
From: Frederik Deweerdt <deweerdt.lkml@gmail.com>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: David Howells <dhowells@redhat.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net] splice: do not checksum AF_UNIX sockets
Message-ID: <Z0-Huo1aqf2OAtJi@xiberoa>
References: <Z0pMLtmaGPPSR3Ea@xiberoa>
 <537172.1733243422@warthog.procyon.org.uk>
 <Z098yHlrNYJsdzhM@pop-os.localdomain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z098yHlrNYJsdzhM@pop-os.localdomain>

On Tue, Dec 03, 2024 at 01:48:56PM -0800, Cong Wang wrote:
> On Tue, Dec 03, 2024 at 04:30:22PM +0000, David Howells wrote:
> > Frederik Deweerdt <deweerdt.lkml@gmail.com> wrote:
> > 
> > > -			if (skb->ip_summed == CHECKSUM_NONE)
> > > +			if (skb->ip_summed == CHECKSUM_NONE && skb->sk->sk_family != AF_UNIX)
> > >  				skb_splice_csum_page(skb, page, off, part);
> > 
> > Should AF_UNIX set some other CHECKSUM_* constant indicating that the checksum
> > is unnecessary?
> > 
> 
> It already means unnecessary on TX path:
> 
>  * - %CHECKSUM_NONE
>  *
>  *   The skb was already checksummed by the protocol, or a checksum is not
>  *   required.
> 

Looking back at the patch series that introduced the checksumming [1],
it looks like `ip_output.c::ip_append_page()` was the only path doing
checksumming, it had similar looking logic:
-
-		if (skb->ip_summed == CHECKSUM_NONE) {
-			__wsum csum;
-			csum = csum_page(page, offset, len);
-			skb->csum = csum_block_add(skb->csum, csum, skb->len);
-		}
-

That code in turn has been like this since the git import. I'm not sure
what that was for and how to test its intent.

Frederik

[1] https://patchwork.kernel.org/project/linux-mm/patch/20230522121125.2595254-15-dhowells@redhat.com/

