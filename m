Return-Path: <netdev+bounces-48429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E047EE4FB
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 17:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BC3E280FC7
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 16:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8973A8FC;
	Thu, 16 Nov 2023 16:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Hn2vy02P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF481A7
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 08:11:07 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40842752c6eso8531615e9.1
        for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 08:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1700151066; x=1700755866; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/FrAh6VZJs4Mwoi9RIsxy0fEAEPO1KkRo4SmyQeSET4=;
        b=Hn2vy02PJ5AsZqBSHxrMq4juswMYuPznYe28tTWbebHVYyJHzfPANPiY7rcttlU2a3
         6LgYbYYmzOYDHka1/1BzeUOj4WfHOWBddmKmLfp+OW+atvMv3dK1tCnh9FEur+qD80Pn
         iNR+zSpU0Dfj+KQMQaRs1fBL+2ScIYmsWDvKjIyXb/txTyWBbXb0/A6sxXQxylDsZAEA
         nDFLiNpI/AuPSLYpoy8Z8uZYaloNjl0jAMfB0pfIMFezt27/rCP8aeNVDd96OBg6JjCO
         33O6jaLS4pSnQCfr47AiWnFtUE9F9PQ5gf71jbYYPdtGRRjRnK250e67KnzgDn3R4Tz1
         Ja8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700151066; x=1700755866;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/FrAh6VZJs4Mwoi9RIsxy0fEAEPO1KkRo4SmyQeSET4=;
        b=mYIRE51OOv0itAb3TEu+XSmnDbofc1Juz3Gt1RNyFo+b4pQabUfN5nPxgz10dDWDoE
         qJbppikUWSAGTZbsWZEwLLvoF2jAinaw1WXwj7elnzpESDXp4Xpa23VFMdlwGO5YH4Vt
         mKK/kjlYhGvnB6tDxxxv9NXQDiFi6Xq1omnRRZ9kMhUZ7U73x0jUqRmDQc686WoW4oWG
         SwoG11T9TPdrrMKVwqo1PKixvoOrW3iivCaYVZAk7H2Ah3vjGLrb4IcF4XKTzXhIdOmr
         NRPtRiKrsSHY7Lvd08qR4pkhd2fWrXsJUi9lj4/bJML+P+mn6dGcQtF8b6zrlK0rIwH7
         pMGw==
X-Gm-Message-State: AOJu0YxqxR6fyfkrCXAZekpn1V+l3iMICK0bGyA8eQl0atyeromihron
	uQnUFLAoaBpVcy+ZAkr86pVjCA==
X-Google-Smtp-Source: AGHT+IH61uvUUEzsBFgCjsCDVmtEKg+RtvAK/2QN8TjqwM+xkBsR6BCisHnnTQA/kSCK1y9d7P4UMw==
X-Received: by 2002:a5d:47cd:0:b0:331:4a30:a34d with SMTP id o13-20020a5d47cd000000b003314a30a34dmr10893482wrc.35.1700151066047;
        Thu, 16 Nov 2023 08:11:06 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id y4-20020a5d4ac4000000b0032dbf32bd56sm14028188wrs.37.2023.11.16.08.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 08:11:05 -0800 (PST)
Date: Thu, 16 Nov 2023 17:11:04 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, deb.chatterjee@intel.com,
	anjali.singhai@intel.com, namrata.limaye@intel.com, tom@sipanda.io,
	mleitner@redhat.com, Mahesh.Shirshyad@amd.com,
	tomasz.osinski@intel.com, xiyou.wangcong@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, vladbu@nvidia.com, horms@kernel.org,
	daniel@iogearbox.net, bpf@vger.kernel.org, khalidm@nvidia.com,
	toke@redhat.com, mattyk@nvidia.com
Subject: Re: [PATCH net-next v8 09/15] p4tc: add template pipeline create,
 get, update, delete
Message-ID: <ZVY/GBIC4ckerGSc@nanopsycho>
References: <20231116145948.203001-1-jhs@mojatatu.com>
 <20231116145948.203001-10-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116145948.203001-10-jhs@mojatatu.com>

Thu, Nov 16, 2023 at 03:59:42PM CET, jhs@mojatatu.com wrote:

[...]


>diff --git a/include/uapi/linux/p4tc.h b/include/uapi/linux/p4tc.h
>index ba32dba66..4d33f44c1 100644
>--- a/include/uapi/linux/p4tc.h
>+++ b/include/uapi/linux/p4tc.h
>@@ -2,8 +2,71 @@
> #ifndef __LINUX_P4TC_H
> #define __LINUX_P4TC_H
> 
>+#include <linux/types.h>
>+#include <linux/pkt_sched.h>
>+
>+/* pipeline header */
>+struct p4tcmsg {
>+	__u32 pipeid;
>+	__u32 obj;
>+};

I don't follow. Is there any sane reason to use header instead of normal
netlink attribute? Moveover, you extend the existing RT netlink with
a huge amout of p4 things. Isn't this the good time to finally introduce
generic netlink TC family with proper yaml spec with all the benefits it
brings and implement p4 tc uapi there? Please?


>+
>+#define P4TC_MAXPIPELINE_COUNT 32
>+#define P4TC_MAXTABLES_COUNT 32
>+#define P4TC_MINTABLES_COUNT 0
>+#define P4TC_MSGBATCH_SIZE 16
>+
> #define P4TC_MAX_KEYSZ 512
> 
>+#define TEMPLATENAMSZ 32
>+#define PIPELINENAMSIZ TEMPLATENAMSZ

ugh. A prefix please?

pw-bot: cr

[...]

