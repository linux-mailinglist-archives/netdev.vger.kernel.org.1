Return-Path: <netdev+bounces-152608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D729F4D06
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 15:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1BE1188B9A2
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 14:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADCC1F37C6;
	Tue, 17 Dec 2024 14:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DbZ42DXd"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2C11F2382
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 14:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734444050; cv=none; b=awDHwkUayYxP4LANa7IN+azMQvvQ5TSF5AsY6jo0XGeQu7RefRxF9gaXc4iLSz/r9olHFJ/tFfCf1yr7SMYoe3X0ipgJPygCbItZNNrrwGji3Ja4yyP3vZcqB9ADiyV1xvuNWi8zbbqG8lo6AKnMzFvYyeLj7W4LHa6A+e42cuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734444050; c=relaxed/simple;
	bh=u2G/km/zcZv189euVvEosnq5VMRDW7m1C7WFaIEGssc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TtbMhQ/BQXKyqnLSc+ozp/dCT1f2x0HjR+I4dQ160wLyEVe5dr3TPMkk8zieAToeKZ06jb14zLEioPWQT/QksOP7npe+IG9oDSTO+MDXDRfOra00nWeajfL6jIYxm2vbCVn1vXsjWBS/O0GGdDAOgGsGFZOnCJ+QzFfnuAF1eTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DbZ42DXd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734444047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iaExxH2ghJldQh3rVDGcBD47pw2sWxnhkuqg9Vht8wM=;
	b=DbZ42DXdrIhUgbGniyFvQ5N6jsIRk+XlKhjFqb4WBU87NYbyLyjufI2hJXAplL+zVQ5Hqp
	QaEVzZ2zQUPHwhGhhHY+M6ZpLLaSgi1/b6tnYwht4Ys+BNVvjphwkg2r2CXG4el0iqUmGX
	nPjFe/90R4GkMRK4emnpNPwhCQB5p00=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-1YnL-gtrMemSckSKz4aPOw-1; Tue, 17 Dec 2024 09:00:45 -0500
X-MC-Unique: 1YnL-gtrMemSckSKz4aPOw-1
X-Mimecast-MFC-AGG-ID: 1YnL-gtrMemSckSKz4aPOw
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-385e9c698e7so2756887f8f.0
        for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 06:00:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734444044; x=1735048844;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iaExxH2ghJldQh3rVDGcBD47pw2sWxnhkuqg9Vht8wM=;
        b=bHzf1Yfr+CiTLNA9aBSm+Sf/+Q7i0kz7KvVC0dUcpaR6nDgulv4MmvN/WFedw0PljK
         BD/Rb0TrgfJygx5ywJq9fQ3Dpib68t0UFX2bUwTFyria/wWFyKwwwEvtdA7zcWanbchq
         8NqlHpc17AA6Tzh8ozrC8VlUC3428iH5WXBfPYjTCPpyZ0L1rwk4YCVgeXWAmYjUyNzZ
         yagj5Oywn7EqC3PnglNjOe1Nox3fC1rAd6b9+vP7ajKNm/+RAjY0PRIzMONy88eHdGZ8
         FzPPJWYybtAycBSyrKPSNaiklWCUA7GNM9aNQeIsZ0COThU09Ux4lFhWTpPThdJQMD8/
         Qstg==
X-Gm-Message-State: AOJu0YxVLkfDE02/jZ/QIAWWEWJMCVCTJcwC5ZYiFdKkE3Qy9lbjyZAK
	4Wxgc1QRtFq6HKx+4gXPvd7y4dj0+g85J/U1mjdrbaKZzdoZE+DovTMnhN5ckCdxWPB6i2mFZVo
	amD8uUgtJagzfraSHoz5KomaT2/IwSsbKFy8C+NAySVKrEh79s9/LJw==
X-Gm-Gg: ASbGncu1IirpA+Yvokddy+pfD9uBR7M9JP/46UBgCUtVorRXj5M+caNKXrC1Cz3lCH1
	2noIf26gRu/od/8J5nkS6w3gzodWg9tWT83CgGNlBfXyvHpwtMnjx5yV2rG1FU1q795U1Ad0B7y
	opjgu2KI42jIjNiO5r+VCv8Wx7m7OzIc1ckZriPPakQBLcU9yuMfsouqUMEi4ZgSVBOmNRqxQ5P
	+zKqS/7yoDriCQ+DEkhVBDQS3ra3sV7ejxCU9A2DybMmisnMPJW7UmHVCiHIAvnnvdW9TI2I+Xn
	OBbFJ2Dufq99wlxzDrODKj+ys7ngGBjZt29n
X-Received: by 2002:a05:6000:791:b0:385:e328:8908 with SMTP id ffacd0b85a97d-388db261f90mr2898811f8f.29.1734444039938;
        Tue, 17 Dec 2024 06:00:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGeMHBDTr3P1Gyz+fYJxIGkLmvyMJWlViICHfz1EFJURhmysG4pRpeHaqRnLKkW/UhAINVfZw==
X-Received: by 2002:a05:6000:791:b0:385:e328:8908 with SMTP id ffacd0b85a97d-388db261f90mr2898549f8f.29.1734444037286;
        Tue, 17 Dec 2024 06:00:37 -0800 (PST)
Received: from debian (2a01cb058d23d600bcb97cb9ff1f3496.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:bcb9:7cb9:ff1f:3496])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c80602a1sm11212512f8f.97.2024.12.17.06.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 06:00:36 -0800 (PST)
Date: Tue, 17 Dec 2024 15:00:34 +0100
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	donald.hunter@gmail.com, horms@kernel.org, rostedt@goodmis.org,
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
	petrm@nvidia.com
Subject: Re: [PATCH net-next 0/9] net: fib_rules: Add flow label selector
 support
Message-ID: <Z2GEAtBwqX7qpo3k@debian>
References: <20241216171201.274644-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216171201.274644-1-idosch@nvidia.com>

On Mon, Dec 16, 2024 at 07:11:52PM +0200, Ido Schimmel wrote:
> In some deployments users would like to encode path information into
> certain bits of the IPv6 flow label, the UDP source port and the DSCP
> and use this information to route packets accordingly.
> 
> Redirecting traffic to a routing table based on the flow label is not
> currently possible with Linux as FIB rules cannot match on it despite
> the flow label being available in the IPv6 flow key.
> 
> This patchset extends FIB rules to match on the flow label with a mask.
> Future patches will add mask attributes to L4 ports and DSCP matches.

For the whole series:

Reviewed-by: Guillaume Nault <gnault@redhat.com>


