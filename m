Return-Path: <netdev+bounces-122365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A891960D5E
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 16:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A91101F234D4
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 14:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06151C0DE7;
	Tue, 27 Aug 2024 14:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DS4OTaxG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576101BFE02
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 14:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724768175; cv=none; b=CD4NijQWdq1gW7JC612II6FD2bDltNJyU4uzQ6v8WlGDcEPc88zHmPQfajBd3HoZsHacEnvL6+punds4lY56ix9s9HE3JOz65I/qkCa8yAmUGFN0xgPT/Wtp1hQ7q5Cv43mJTS6wsbTcvViOAEqtB6zsa6g7W1yL1NsYFqGXUvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724768175; c=relaxed/simple;
	bh=XXmbb0t7y0c4oZ7Xu9QG0xMGo+5vUrt+cGWNQunXL/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D8WJ3DnHChY/7OOlF4LQ5bqtk0Zv4XXhVIvL8PHXBbjkp1F30FVmivsAXK1mpHNJd19ga/DQvLVkcxJiL00AINe4odXQqZXQ8iwWQxeX22uU9GdRRp/YZGbUhl+hU78F0YnWkQ8MU2IoqsH0uq2r4Nm/NbDyA2fdLL63SDhuco4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DS4OTaxG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724768172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+XAb/pp4q4FbprZjC7JXIKvxzAlOoqRRApsF46Uml7Y=;
	b=DS4OTaxGUSg3PbCYt77Q0tw7mZ0nSd7lot5DKAoiHSgatMJUdtnbaxsvagF6uslw+q7yMW
	1rgYOzoZWR8BvG/OToe6yRxCm5BdXYFx1JjDj2FvDm442UmJK63vv5pqKYsq9ZH45KkK+w
	gEX39gAze9+XqXpLICtOO2pfHxJKjKA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-Ib7Ym6MWOqGTYKYG8ioooQ-1; Tue, 27 Aug 2024 10:16:10 -0400
X-MC-Unique: Ib7Ym6MWOqGTYKYG8ioooQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-367990b4beeso2832118f8f.2
        for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 07:16:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724768170; x=1725372970;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+XAb/pp4q4FbprZjC7JXIKvxzAlOoqRRApsF46Uml7Y=;
        b=kTnka+1lHciiByPre6nthafOqp210LRCWfdqcoVXfJ5h7YTpUDnoyEeWek98eyOLBb
         YQLAhHbrFWmDRAhtIdjIDKDghChZGaoZZdUM+YE2SDJJWgd1nSbilQMnIyWTSLyc/8Ru
         0EyeAkDwmBpBxCmzC+TngbBpiDi/iUl96hWAt1dP1sXpSB66R16GtSmFNLBdU/yNKLsH
         Ook4n27TjdTrer3Qv1j0s3DyS0+k3Y9IwRA2hHam1GB0VeCAara9VggCZw16FQuWUsPV
         EeSSzy9O2Cdo7mHlCnTxHQWhO6O5nFixXAMsathdF+AjT8XTx/BHoxhINsbfDGgk7hy/
         ZKGw==
X-Gm-Message-State: AOJu0YyRLqyMVjBaBiKE7DWd4d65BHdBD0iYl6djh7xVl7jqkH0WbV2v
	mwCnbEBHvHgM+v1scP6N+Iw6Ch6VNk3cLBunlszsa3X6Nl/RdN2xnoPJxJIpI+lNiLbUzLB2ebp
	Dlf9V5wa7M+Bgj9Y2vkO3eoHLigga0aTH4gZ0GhAI/8zEUI0PKIdRWw==
X-Received: by 2002:adf:e244:0:b0:367:8876:68e6 with SMTP id ffacd0b85a97d-373118d099dmr7827763f8f.48.1724768169694;
        Tue, 27 Aug 2024 07:16:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFzL0sCktsHBR3BS7aVVD4sDlVTgMk+MinAaNmqlsQPaLUyr+x5t75wMdmr6hJy9S+FYgU/g==
X-Received: by 2002:adf:e244:0:b0:367:8876:68e6 with SMTP id ffacd0b85a97d-373118d099dmr7827733f8f.48.1724768168935;
        Tue, 27 Aug 2024 07:16:08 -0700 (PDT)
Received: from debian (2a01cb058918ce0010ac548a3b270f8c.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:10ac:548a:3b27:f8c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37307c0c9c7sm13389909f8f.0.2024.08.27.07.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 07:16:08 -0700 (PDT)
Date: Tue, 27 Aug 2024 16:16:06 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
	john.fastabend@gmail.com, steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 03/12] ipv4: icmp: Unmask upper DSCP bits in
 icmp_route_lookup()
Message-ID: <Zs3fpuuLDo7vPBQq@debian>
References: <20240827111813.2115285-1-idosch@nvidia.com>
 <20240827111813.2115285-4-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827111813.2115285-4-idosch@nvidia.com>

On Tue, Aug 27, 2024 at 02:18:04PM +0300, Ido Schimmel wrote:
> The function is called to resolve a route for an ICMP message that is
> sent in response to a situation. Based on the type of the generated ICMP
> message, the function is either passed the DS field of the packet that
> generated the ICMP message or a DS field that is derived from it.
> 
> Unmask the upper DSCP bits before resolving and output route via
> ip_route_output_key_hash() so that in the future the lookup could be
> performed according to the full DSCP value.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


