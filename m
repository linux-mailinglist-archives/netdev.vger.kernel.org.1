Return-Path: <netdev+bounces-127286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 218B9974DE5
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 11:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 414301C2083B
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 09:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DCA315381A;
	Wed, 11 Sep 2024 09:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RIq4PGJB"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E6813A884
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 09:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726045608; cv=none; b=Tdt+BxxC/uFL3ue8srW8zxIHDv0v66iOaN+WSyRPWR7AYXWhlJ20Pu/GaX9yMwSaov5YTwufLSGeBbvmIroIxkDVdCSX52mPfgRvTzDLL2dKUVmCFEBzudijC3OIWp/+oO2XcizAspgHKL3IpENgkBT1ofF/gvdqZNgiN0HWuYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726045608; c=relaxed/simple;
	bh=Beuwz4CZLBnpVz5GXMl5YQUBHz0z9SA5b79AR5i02OI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kRtOr15XAn8uEjJFubXJip3fiIZqG+F/8i2Ymcq8EqiSQshGrUwOH0v3jP0G3vszvQ0abG/+pb1vjQy1xozD3pKRlmpyVfpG0VoLaa3LXPABJhbaTWDY0dxz4faQ+l1dje7w3Y5OKaXoO1eTS9QFBPvpHaqCS0q9+UfKw7V0+os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RIq4PGJB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726045605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Beuwz4CZLBnpVz5GXMl5YQUBHz0z9SA5b79AR5i02OI=;
	b=RIq4PGJB3rxXcdUxP/4wdfLXngEL3wNQtVLpqat9UwCnq9N/0vm0evn0MqF0oDJU6CoaJ2
	NLmlRl1CRBSYGs8x3fZYgT/lDyzw0z2HI0tyVQBoQbyXqo2vUVOTAZ1yW8oTFrlXQBsdPe
	fIH4FhrsixieEiTtLXeY4SJCFCE7/hQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-115-v4akg7mEPHeSz5yMdAe1qw-1; Wed, 11 Sep 2024 05:06:44 -0400
X-MC-Unique: v4akg7mEPHeSz5yMdAe1qw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-374c32158d0so1008711f8f.1
        for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 02:06:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726045603; x=1726650403;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Beuwz4CZLBnpVz5GXMl5YQUBHz0z9SA5b79AR5i02OI=;
        b=EDEs7F0kC2MHBbtY/7QtuqhPZT4E5paTnSU3Xwxd7D0m3b3h4Ez+eWoOX9n7MartuQ
         gGUeJ9ooeglugjvnGlSvPLTTpKSASy0eNoGAmbC0FFMrQF4BTBfg/9U21qTPeJdNtNrw
         Sgahqe5mZBCSKwLHBACymyjj3xHYNCHt1SLoH5aNxKRjTi7WTfEEFw+giQ7fQSAUyOaH
         d7D3khCCd7PGpZIU6apkW437gLIXMgTY2hg3G5bzHxjtuM4dh7fIrWITaDa4/sQo2X49
         fpWn1TJE6/9Wts4InLy8kZDE+ZU8cE8+Mypob8/2JB2HLBxVIfLx8ovV2jd+b6pGGZcU
         nacQ==
X-Gm-Message-State: AOJu0YzyofP4ftZTq6ymcr8P0Wcvq31tUY9POytjsLiiYS+Kkm5/hszt
	ANrtP3jSQOozxEmiH/eeQvyUB0rB2/T26ndCgfaWkPQM88IPwuBoArmulEhfrpiZXqCkIvJio3o
	zPNhQpIxjk1XcdrBidHiyJCgdbkTKn9Rl++x4Oz7Vy+LQRQ0Psm8k1A==
X-Received: by 2002:adf:dd84:0:b0:371:7e46:68cb with SMTP id ffacd0b85a97d-378b0800161mr1316793f8f.50.1726045603059;
        Wed, 11 Sep 2024 02:06:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5nMgdaJfgpSmKiOShtkSf9LTbhvlNQCemCe/gnCThm+f9BlMl9IRkVPpgbQ/6q7vcb1cTtQ==
X-Received: by 2002:adf:dd84:0:b0:371:7e46:68cb with SMTP id ffacd0b85a97d-378b0800161mr1316756f8f.50.1726045602037;
        Wed, 11 Sep 2024 02:06:42 -0700 (PDT)
Received: from debian (2a01cb058d23d600901e7567fb9bd901.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:901e:7567:fb9b:d901])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37895675cb5sm11033483f8f.53.2024.09.11.02.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 02:06:41 -0700 (PDT)
Date: Wed, 11 Sep 2024 11:06:39 +0200
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net 0/2] bareudp: Pull inner IP header on xmit/recv.
Message-ID: <ZuFdn61NlY80sCyO@debian>
References: <cover.1725992513.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1725992513.git.gnault@redhat.com>

On Tue, Sep 10, 2024 at 08:31:00PM +0200, Guillaume Nault wrote:
> Bareudp accesses the inner IP header in its xmit and and recv paths.
> However it doesn't ensure that this header is part of skb->head.

Forgot the Fixes: tag... :/
Will send v2 soon.


