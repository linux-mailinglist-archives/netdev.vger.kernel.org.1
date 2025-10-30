Return-Path: <netdev+bounces-234393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5274AC1FFE7
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 13:26:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C04A134E0FB
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 12:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28AE93002BB;
	Thu, 30 Oct 2025 12:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CPxcQ94s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675721487F6
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 12:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761827158; cv=none; b=A3dWmLNvUFTzFxrwzvLz0RwRWIEjsW4l8CxOCD0oGNtDM2N4363F7uNoHeL/WLU1cwkqSRhpKBC4PP1hYSA1ndB00RBQwjNARPbcOJN825G3K1qDqmTTkS7i+I5AmYmLpVLk6+YLq6203tQN2bntvMLyhIUYdsc5PCKbawK+YtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761827158; c=relaxed/simple;
	bh=WIT7iMRJ7OSZlliXRHCGuVNFqaRK0Qn3YehYj0PAXkg=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=dq9KqxH7bdAEJ7S29Gt3VVmG59PgJcmjGUW99qxEq5J3UP0XTn1uC3Yk5V6Tyv3ehp2+RgJVXvRs3dmDRrpuS6QY8g9fZ9bGCVf1obfCU5GrSJfgufvytPuHNzuyuv0XoANq4sndPwUaj1XxSPF/L8TptPEnNTsU1MdpsD6Uquo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CPxcQ94s; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-46e6a689bd0so10021975e9.1
        for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 05:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761827154; x=1762431954; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oGeWVKiRUJ90B38LnVV+UroicCqLs8iq7lgOfzkxg3k=;
        b=CPxcQ94suzsWC8OEXwHaT4ivDxSzL3bwRvOV1a7JMe5anAzgCPcGIZCv2JP0/t9dEs
         HqOrDiH5zanLtbx60CrHVIqehJj9X51cyF9qv9NHooFG8A1T1ArL47+T9nMF0NPH8fyN
         w6Ul1Sbr354CovJUnvkGFqAz7AlXT0E2edLWYLjh9dWBs/lkx6+AJOhar6z8M175qrDZ
         ekqwHPwRwWx8eLgd9hc/F32Q5NlBm8vANc2ztGhJWDpQgJ+lCSkEDZr871ywTOO2rRVx
         vwMQo29YB1DovetZscQroPkw+Ruvj+jhdJFmWygRCHE8uLb5URl+FlYTq2zhgUFaEpQk
         nEGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761827154; x=1762431954;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oGeWVKiRUJ90B38LnVV+UroicCqLs8iq7lgOfzkxg3k=;
        b=DiXBu7U8msFBuhbtmZw6qKjHsX58zUKfyDfuuzmxGqkDqEw9ZSwzJzFJacjSKr0sVR
         dnKZZ7zyfqjAyovl0INPF0G+EsYz58RKNhvCWU5NQS5HxTqbZ5bwXeT/0WoW6899v5aW
         O3V8WH2SmE1KI26Sqd686+V4cOetwFPHLg0+/JhMinRg68sQlsvOM7wDmw2u5b1Or7vk
         V8tJ7xX2hQRMEExM+/BIXtLqdPD0rs8FuyYlBr/Z/tiZbJHH2IuNb/1zOlwvs/KgQQBl
         alRNhQkuCSjmhggI4t6G0Lwy4ILi5Fx5mj1EEbQVc1TQqT0ueh2gmanzTNLjy47mOipE
         yX+w==
X-Gm-Message-State: AOJu0YxbxL1JJoVC/y3MwHHvITYElLiAgM50NhBV1L0KTxespiEsVyVl
	wyHqHyGC39u6ZWARrcJM3l1pmX0jDB9g+WuxNmKsOeQIasnZojpAqmdlx1/khdqS
X-Gm-Gg: ASbGnctt1MEpr7nN8HVVvqUCvFOGsehkSFeQkCCgWzXjsNNqS4a2YkYn0dBnpX6CSa0
	GbqsefRX6OpPAYKHgnkvXS4N9e+PYPxYfPva1GTN3RMtZKuLni+iHRmQplsBJ3E/qupcLW8jfS8
	6g91Wv5GGnbCStUltyhf8/lpXikxyHGt8fjXNSyT501dxzs84YJP5WW1PIvp0PJ8xsyFL+Xuq/3
	FHL3djmgWMvGtebVCX8BgmXCchVbgvAu3r01Fgy5ogqSYcNvKjl+kY166JJAO5ejkAwsw1qF+Sn
	dsy+1WAVYJNvxfV//920SSRrw+rgwN2l6suDpmKfn0D3hPkTuTzL5OU5wzY+WN9w65iMulDCroO
	5NqIIQtXsAzWoxA4odQmiTttMaWDlVGdYRkdModFa8ROCosLm5Jabp7CEvzrc+rC8ymKQ2nDay7
	htEOP1sYVrtFxrtAC/WnJgSjE=
X-Google-Smtp-Source: AGHT+IErZdBpTz1fHBDyJEqgwajA23XD6cRF+ZC/Od6th31hfbyZ1eqg6dJ7PKKt1YwPep+CGF3dlg==
X-Received: by 2002:a05:600c:35c3:b0:46e:3d41:6001 with SMTP id 5b1f17b1804b1-4772684f823mr31649405e9.34.1761827154212;
        Thu, 30 Oct 2025 05:25:54 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:3088:3c7e:2941:e648])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477289adaf8sm46592765e9.7.2025.10.30.05.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 05:25:53 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: ynl with nftables.yaml
In-Reply-To: <MN0PR18MB58472AF35605FF6FC96EE6DDD3FBA@MN0PR18MB5847.namprd18.prod.outlook.com>
Date: Thu, 30 Oct 2025 12:25:17 +0000
Message-ID: <m2o6popoeq.fsf@gmail.com>
References: <MN0PR18MB58472AF35605FF6FC96EE6DDD3FBA@MN0PR18MB5847.namprd18.prod.outlook.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ratheesh Kannoth <rkannoth@marvell.com> writes:

> Hi List,
>
> When I get below error, when I execute the example command mentioned in https://lwn.net/Articles/970364/ .  
>
> ####################
> root@localhost:~/linux# ./tools/net/ynl/pyynl/cli.py  --spec Documentation/netlink/specs/nftables.yaml  --multi batch-begin '{"res-id": 10}'  --multi newtable '{"name": "test", "nfgen-family": 1}'  --multi newchain '{"name": "chain", "table": "test", "nfgen-family": 1}'  --multi batch-end '{"res-id": 10}'
> Traceback (most recent call last):
>   File "/root/linux/./tools/net/ynl/pyynl/cli.py", line 163, in <module>
>     main()
>     ~~~~^^
>   File "/root/linux/./tools/net/ynl/pyynl/cli.py", line 123, in main
>     ynl = YnlFamily(spec, args.schema, args.process_unknown,
>                     recv_size=args.dbg_small_recv)
>   File "/root/linux/tools/net/ynl/pyynl/lib/ynl.py", line 468, in __init__
>     super().__init__(def_path, schema)
>     ~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^
>   File "/root/linux/tools/net/ynl/pyynl/lib/nlspec.py", line 462, in __init__
>     jsonschema.validate(self.yaml, schema)
>     ~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^
>   File "/usr/local/lib/python3.13/site-packages/jsonschema/validators.py", line 1332, in validate
>     raise error
> jsonschema.exceptions.ValidationError: 'set id' does not match '^[0-9a-z-]+$'
>
> Failed validating 'pattern' in schema['properties']['attribute-sets']['items']['properties']['attributes']['items']['properties']['name']:
>     {'type': 'string', 'pattern': '^[0-9a-z-]+$'}
>
> On instance['attribute-sets'][34]['attributes'][1]['name']:
>     'set id'

Yes, there is an invalid attribute name in nftables.yaml. The attribute should be
set-id

