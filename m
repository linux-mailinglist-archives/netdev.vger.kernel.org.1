Return-Path: <netdev+bounces-229515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4850EBDD569
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 10:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8D00192223B
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 08:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F0F2D5419;
	Wed, 15 Oct 2025 08:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Grr4h1cW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F311F428F
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 08:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760516258; cv=none; b=PqckfS+BvvPFks2w4Mkt0HhKmRRU+vWun3rnPkUUPzk3lZsvSJdIJnHuAxmnFJjnqSL0g0RKD0xN1PNHJHGpTB/zrp9qE80aPsFmmFG9DkZR51DPnZAvqIMT0/YpzGr0QHiwLn4sZx9d21W28c8U2sOsT2pGc/wehQKIqh6jagU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760516258; c=relaxed/simple;
	bh=u7jU1Xv08wAnvpqXtqAEXR0gpxoiKr/0ke+WCBJprzQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=vCQdYMbWbvK3uV0eWPmbESCsMkeVY0GkANivXH6j258QxM+pyxGLD4v2c/T97Bjcjqrqzi4bjRl8YxaWnrgIpYnuzJSF8BF7kJEh9J5Fxs3yosz4CYDNlKnvIJeg3tJUmUWtOWPeuG5x7Ru1eQR2Iv4835aKYXeOfCcsAT9JUk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Grr4h1cW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760516256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u7jU1Xv08wAnvpqXtqAEXR0gpxoiKr/0ke+WCBJprzQ=;
	b=Grr4h1cWJoZyKdReyQQ23WgW+dwO/tZXFr+gNNFmOkNikQtJ22YFTpiMkfCKaLfx+50Nzt
	4tyDFX6/fZISpAegriBOG7JKh/ty4VYqiDcnBSeA49Z58tz/DQZRLHDJ58XZriutpagt4n
	T4ACu8C8cWtI+zzcxCfvdBe+LfklN5c=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-rl6wGPUPPICvFqfk7mY6Gg-1; Wed, 15 Oct 2025 04:17:34 -0400
X-MC-Unique: rl6wGPUPPICvFqfk7mY6Gg-1
X-Mimecast-MFC-AGG-ID: rl6wGPUPPICvFqfk7mY6Gg_1760516254
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b4068ff9c19so850085466b.0
        for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 01:17:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760516254; x=1761121054;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u7jU1Xv08wAnvpqXtqAEXR0gpxoiKr/0ke+WCBJprzQ=;
        b=h+cSstmv0sbV85rgsJylZptP/sgf9GFfIcSEi+xsCEZurKKvEILd83S5KgXeRteCtP
         M6yjARO9tV624X/s58eKRTxUcwN8c7t7ROAxPU829fRijBVOqd0d0HiW+Psud0k2/ZgN
         p8kK6y72AgFZhIUIX2XQ+gk3S3cd+yYASxdaHBpZPe5idK64d+pYH6BH+lpD3Z8TLIKa
         RneXQumy+BK5vMJReWPSSvXKVPCOS2x3P6LymgjPpTR4SugmLg+0hNfjJ6hhHzb1mbOt
         9rGVWbUS1iQjIga0JZKKMERXfDIaXDiQzN+Dsa6RGIokj4bBeYURaEtW1Uw3oGeCYmcu
         sP9w==
X-Forwarded-Encrypted: i=1; AJvYcCW4gddcKnnFw1Ln5DkPE0uiwzFaM9tkpV85mMNrjAnTsnKhkhNgWV/6i7eMuKgl72UZifMSCuo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbcjrGpLeAwL+QAIYd9jLmrj0O1PvzMUfZ2oB3cbCVoCgeVdcj
	nzu05qKp/YjPrB2TCSpqapya7T8zri4IcIE8WULLcKYCo1HliZB5cwR07h6ZW0J6HVNI7jeiUln
	YVsTEMEYGZaeJWZ7KvdcitXgj7/GJ6mjQl2A+L9T7MulExKT/4Zhmt7MHcA==
X-Gm-Gg: ASbGncvMNGe/3KvhIYtDzVziLqagfxcAjeLCbIadFHrAwscb94TKaQ74SCDYPDCSL5I
	hOsw1TGu0sLI9y5nRy1z1RbqArWwYmVoLAmmEhx4D6GLfEBJUwYtI/r819nn2qVUFkjwuoGN/0G
	tiK/OB7ubzz4SGfpVjV1vYcYEhcaKN2WVAydmr9Y8Jh20zTfz66151OH2UDtEfZXbcNS0sLzt/A
	lltwZp91jHMdFljGKVdeJ2SURVEoDpKEMPIADUtvkDACAUMm3OdyosbB7iTj15fFXmFi9JQULnR
	VysDt7+5hVmFGlBHM3U7FlNode3YoGORzXdIabBw9JCTGY9Vzg71JiMSj8pFEu/Vy6A=
X-Received: by 2002:a17:906:99d2:b0:b57:78fa:db48 with SMTP id a640c23a62f3a-b5778fae3a2mr1526139466b.51.1760516253582;
        Wed, 15 Oct 2025 01:17:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGk1Q7tQWEKYNr71jRhgYiWbIOlEpcKxoKcxcVt7Ii3o3/DsMIhKVeK2DJdTtpziZMogxiBUw==
X-Received: by 2002:a17:906:99d2:b0:b57:78fa:db48 with SMTP id a640c23a62f3a-b5778fae3a2mr1526135866b.51.1760516253065;
        Wed, 15 Oct 2025 01:17:33 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5cba06b7f6sm173993766b.30.2025.10.15.01.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 01:17:32 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 0DBE82E041C; Wed, 15 Oct 2025 10:17:32 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>,
 Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn
 <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, Eric
 Dumazet <edumazet@google.com>
Subject: Re: [PATCH v2 net-next 3/6] net/sched: act_mirred: add loop detection
In-Reply-To: <20251014171907.3554413-4-edumazet@google.com>
References: <20251014171907.3554413-1-edumazet@google.com>
 <20251014171907.3554413-4-edumazet@google.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 15 Oct 2025 10:17:32 +0200
Message-ID: <87sefkfujn.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Eric Dumazet <edumazet@google.com> writes:

> Commit 0f022d32c3ec ("net/sched: Fix mirred deadlock on device recursion")
> added code in the fast path, even when act_mirred is not used.
>
> Prepare its revert by implementing loop detection in act_mirred.
>
> Adds an array of device pointers in struct netdev_xmit.
>
> tcf_mirred_is_act_redirect() can detect if the array
> already contains the target device.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


