Return-Path: <netdev+bounces-123212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB3396422D
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 12:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EC3FB24689
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 10:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72D518E370;
	Thu, 29 Aug 2024 10:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JWOcp8rs"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410D415AD9E
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 10:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724928477; cv=none; b=fk3fF+c0ZWWQ8KJqIcOxgHrGCojabgY0JG+owOrd6+pSIPmUeA1oO9Yqb03ChqsELMilQYxgJcPe/8loctTWZpUBhYH2q3kvUA8VtNJLy4YQDyL3e7BVRlFSvDTBEy0AdoAyE4iZrxtRF9idqynzkDBbw5p1uhrN1gMU6qSvuIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724928477; c=relaxed/simple;
	bh=aYR71yX/lEP84Q/cBlgRB5k6OYd9aKz7KXGYxZZ1rRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q035FxNk7NGKDPtD7mGXehy4M+ZIVeOGlBi9Rf9e1cKwwK4QF08sj5dcN5rIxaOWNyZrk5p36sFoG6duwa34vhp+Ea0sWJofl2l/No+7c4yBK2Ch4f4RH/iGfSekAm0i0hQPj5hlqi2ms6pCxQT2AFVzjn46A/64vYYYb9mszSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JWOcp8rs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724928475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xbs/v6QvX9Zgxt8njukpApcL5lIchC6Qom7gbhkYcJ8=;
	b=JWOcp8rsxBFRFb5/8Idt+Si05AYuMX5Qfl/OGOm1Bqv/kG26xAnh6uHn/9oZwMpfieAHmg
	hZROhYb5xrmvGhEcgvuS8XGBRunrE34+bSFF/JL2Homg3ep9WZdbZToMtwnKQ/5adG+xmk
	xKsFLUPQP01oxSl9hneb80j1uZ/1fc0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-8P6ojS0sP-qIKdieuw6BGw-1; Thu, 29 Aug 2024 06:47:54 -0400
X-MC-Unique: 8P6ojS0sP-qIKdieuw6BGw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-429c224d9edso5484735e9.1
        for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 03:47:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724928472; x=1725533272;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xbs/v6QvX9Zgxt8njukpApcL5lIchC6Qom7gbhkYcJ8=;
        b=KqTZawl/G9y5f6rwGnh/zK7EXmiGuC0ipY8yNvhNFKUxQltrbWTnz4BRbgUS6c/H5s
         ByEh1l0mxO/Ufb1zSfVVxrVhoMXg39vUMbhkcijvspZwfGUJdMjA3zIDfcnHPGtOSNIw
         7te/LKlcQxYvmWgMgA0LjlFXMK1M3n0ccSgos5GBkGz5d8OIvyxa+gSp++HVD31qCZJg
         NuxmVFdWqch726mzUb+/ifaEjIOPuuFeJA3+kaC+PJ4YAaoChcZgxS9C/CtsVkNQNcSZ
         vnk/jiElEsxk/7CQBm4G/OXtLGl/t5jb8k1xK5jfST8a4qGmfjP9Zy6TeQMtcGPj3o9/
         YRug==
X-Gm-Message-State: AOJu0YzzF0rdYHGf6t7B44s91wNqnkKOe8/dC26HzWs0HQimgpG3rCEz
	ctNWt0/74FU1nTCdjoDakpPO9IV7MF9aBBcVjOTU/BQFBNCdQCvq4fiqNn3TqeDxJ+qqnUeeQoR
	u16hBdNRRQKvFF3RPnRozmxY14PnIFcKNXo0oGm8H3hKIecLoNWiY9vhHAjpbXA==
X-Received: by 2002:a05:600c:5110:b0:426:6a5e:73c5 with SMTP id 5b1f17b1804b1-42bb01fb87cmr16915185e9.37.1724928472381;
        Thu, 29 Aug 2024 03:47:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG47hK/NpUyrB2KWuczXd8vbY1gztNea2O4yagYPeZKtiaQ5r4qXRxUyfdXjiPhurJE/j3zRQ==
X-Received: by 2002:a05:600c:5110:b0:426:6a5e:73c5 with SMTP id 5b1f17b1804b1-42bb01fb87cmr16914845e9.37.1724928471549;
        Thu, 29 Aug 2024 03:47:51 -0700 (PDT)
Received: from debian (2a01cb058918ce00dbd0c02dbfacd1ba.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:dbd0:c02d:bfac:d1ba])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ba6425958sm48196065e9.48.2024.08.29.03.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 03:47:51 -0700 (PDT)
Date: Thu, 29 Aug 2024 12:47:49 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
	john.fastabend@gmail.com, steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v2 06/12] ipv4: Unmask upper DSCP bits when
 building flow key
Message-ID: <ZtBR1Xws81abORhg@debian>
References: <20240829065459.2273106-1-idosch@nvidia.com>
 <20240829065459.2273106-7-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829065459.2273106-7-idosch@nvidia.com>

On Thu, Aug 29, 2024 at 09:54:53AM +0300, Ido Schimmel wrote:
> build_sk_flow_key() and __build_flow_key() are used to build an IPv4
> flow key before calling one of the FIB lookup APIs.
> 
> Unmask the upper DSCP bits so that in the future the lookup could be
> performed according to the full DSCP value.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


