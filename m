Return-Path: <netdev+bounces-110374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9058192C1F8
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 19:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C95F29353D
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 17:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A430185609;
	Tue,  9 Jul 2024 16:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LOcVpurC"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058CD18561E
	for <netdev@vger.kernel.org>; Tue,  9 Jul 2024 16:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720543986; cv=none; b=M6mO3nNWp2WZG2IxDztE5kkrIeX7mLgwOg4C8KcdGgietCxfT4wFoIfJ1z31h3PcakslG6hmbfAgJEFrEHsMEghnk6piHcOACBnOvbC7BZznIP8yzFbOJocrCuKzwfYiBOEaxkwdY2S3DlI1wavRzbaNoaNVGPMPQius+HNbS1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720543986; c=relaxed/simple;
	bh=asVho6LyvrHD7BTUGcDSPeAn6LcjJzG6EHzs9v+6tKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ph0+oO2pHrzwnsw8hmaHfVstCZkrUFsGo0cYic7S0o/k+BM6UFv3F/6+z9m5cvfB5zts6HwKKI+us7D5mqBRxMP/mSgixgUBkr/q6LKD1vJ56c/Mw+YndhgwB6O81Vc1RYctxpmq1zOz3G8YkE77s9v84ObHEyflWCywk09+7hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LOcVpurC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720543984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=asVho6LyvrHD7BTUGcDSPeAn6LcjJzG6EHzs9v+6tKA=;
	b=LOcVpurC1zrLanLTEHZK46AS1P3C8zPdH85I8CGFUBgBTh2RL5oBh88Chvf0fUoBGl1TeQ
	d7WY1WLQx1S+uYqEWBlw/w8NJIF45I0I9A+yAKHi7UcgXrdAIe+AgkwG2NlIvOcembXk+8
	7X3cQMKZVfaqedtZeoJ+MrEqEe4nsaE=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-w89eo2-fOBKSaZxIsVoQCg-1; Tue, 09 Jul 2024 12:53:02 -0400
X-MC-Unique: w89eo2-fOBKSaZxIsVoQCg-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1fb269ff96bso30262155ad.1
        for <netdev@vger.kernel.org>; Tue, 09 Jul 2024 09:53:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720543981; x=1721148781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=asVho6LyvrHD7BTUGcDSPeAn6LcjJzG6EHzs9v+6tKA=;
        b=SLdEDwNBPHU+cgEptUR75O2Gvcy0bBh2K5OE+zi1NlaSFGIDguz6tU252Brjt61CYF
         gXu0vd8WqoMPPW0pl4al+MwWWMk7FawkYJ52dZLt806a82zqX6tti4O9qdX84/T/y7Qr
         WikBKed1+pCa1Y+/lYbWtCZ7nKscw38Q988C/2Wa9Arvw6hQ6KkInunX+5SLktvPKEMf
         /4hATDFt1/nqP32EWpUEWjC/gYTQ1fhfWRa6RBlVdXbiW1QNLsdJMSbseCI70X7ycOzR
         mE3OMKVbDJkNbpPd5TJml8WSAnhzSyjx7MJ9UtN8EUt1ix/bcFUCZSdMZs5tU18hcXBO
         brIA==
X-Gm-Message-State: AOJu0YzyPzWqhxPW1g/9moMEBHG+t2BaXkfOWcjbmzOp1EA0DVMAXlnp
	TfXQEN3sTN07Qf5V0aJsjCPOX9nbO7qzfkQTHQYOmzPWCuDC5yp1g1dD99h5GVpSU9m0KjZ2xIg
	hl7GAJtenjHiW6ijdoyV/80sT9QmcSrn1Ck47YqSgS/ExcW9n39bu101M/cAmDb03vLrPRGcJXw
	i87qJ/agXP+PD9r2p2UgnBu/n6rZHP
X-Received: by 2002:a17:903:186:b0:1fb:58e3:7195 with SMTP id d9443c01a7336-1fbb6cd186bmr25609465ad.11.1720543981613;
        Tue, 09 Jul 2024 09:53:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjlrmhgUpUlN7BW+PcaWbKq+/s4BVAK6LBnpJZZch5y3gF9SSouA8oyK/R0rkaxMPreuHVQIjkrp2zUEC5VX4=
X-Received: by 2002:a17:903:186:b0:1fb:58e3:7195 with SMTP id
 d9443c01a7336-1fbb6cd186bmr25609195ad.11.1720543981178; Tue, 09 Jul 2024
 09:53:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709163825.1210046-1-ast@fiberby.net>
In-Reply-To: <20240709163825.1210046-1-ast@fiberby.net>
From: Davide Caratti <dcaratti@redhat.com>
Date: Tue, 9 Jul 2024 18:52:50 +0200
Message-ID: <CAKa-r6uyEz650x+TVZEsj3WiZ-OnMYycexEuiYf=HmgtiDx7iA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 00/10] flower: rework TCA_FLOWER_KEY_ENC_FLAGS usage
To: =?UTF-8?B?QXNiasO4cm4gU2xvdGggVMO4bm5lc2Vu?= <ast@fiberby.net>
Cc: netdev@vger.kernel.org, Ilya Maximets <i.maximets@ovn.org>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>, 
	Ratheesh Kannoth <rkannoth@marvell.com>, Florian Westphal <fw@strlen.de>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

hello,

On Tue, Jul 9, 2024 at 6:38=E2=80=AFPM Asbj=C3=B8rn Sloth T=C3=B8nnesen <as=
t@fiberby.net> wrote:
>
> This series reworks the recently added TCA_FLOWER_KEY_ENC_FLAGS
> attribute, to be more like TCA_FLOWER_KEY_FLAGS, and use the unused
> u32 flags field in FLOW_DISSECTOR_KEY_ENC_CONTROL, instead of adding
> a new flags field as FLOW_DISSECTOR_KEY_ENC_FLAGS.

for the series:

Reviewed-by: Davide Caratti <dcaratti@redhat.com>


