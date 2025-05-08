Return-Path: <netdev+bounces-189041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2806AB0000
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 18:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7586D3B6C53
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 16:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45AB927F747;
	Thu,  8 May 2025 16:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WE+z2BBn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A2727F16B
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 16:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746720833; cv=none; b=jXBYR9l0dAVBUSz8pISw5U6TjMacyYso0D5hO2kKzbkCIYuP8zDcoy9p2OEMrNQ36IvJWZIB1JLi26hgfhNSQjIxeHOBhbZoLgUpCvK7V2ePZNkpHSR4R6t/sO++VZ1uTvmHElwuXzQzzFUeWFPQAK1xjOagloZKIlj7/VkhHmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746720833; c=relaxed/simple;
	bh=hLIHH43hw2mwMtowkdXzci7nzvtEBhnh5wMlQpSMYos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DfLK1EBTbFl9R7KPQAb4sGZypx5bA714NWpnNrIrpbRfoXRz7qx2IkmLXHoMeTS98a+pk8hLueXdHa3WPQt2L3IwOGg/VTO/nMzMrEVc/g+KuMI0BPyYE12VQxSQ1EKpMpTForVKeoGQH0GYXetqeKXaFTrH3qxCpAsuo9kqwC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WE+z2BBn; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22c33e4fdb8so11492655ad.2
        for <netdev@vger.kernel.org>; Thu, 08 May 2025 09:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746720831; x=1747325631; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+NZB1OxaHiCrBhwVFacJbmIM2grMFuh7zcI08fdAfMI=;
        b=WE+z2BBndsK7thxtuOy4KH2EMhO4Ucs4HZCkMaz2aDRxBw4chtlqAfkElGio6src1D
         WU22U74jL3oAa5p4Z90fRak57WyTz01GwPz3JeI0yF1nUhrWZIg5T8/bmoYGZYl+NkUB
         2pWPbcjshj1LA+nTWATjtbQe43a0JAcsoj/o3182W4VoW66QMwtF59t8o6IMRzl4rf6G
         bS0MPsF/IhZcXPilSNl2r8/T0nYdcEfE0qEC/DgF/pFJR/lSP505wQCNnOaviKP51iyn
         RWh5p6nc4kuC2+EBD/bJSbc4KEoTj6J4QtCbi139Qy/BXBh1Xe11pcRMF7+KeXpV1B9Z
         ZMag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746720831; x=1747325631;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+NZB1OxaHiCrBhwVFacJbmIM2grMFuh7zcI08fdAfMI=;
        b=fozLAngmhFxC2DR30GaMhRfcf21Ug8Uwfm/8HvLXV8oiUo9dISHaog6+m96ulTiQhK
         s8JAii04f9qfvno0+tjdfpGxBTZP7+Cez9PohWvrUn68QPsWAgHMN8EPLD4+PXOXYQ10
         uxi4zIsrTdnmHnLYv6SE/PAsMcrScpKyIsmRcuvxZP0flpq66X2rQGCd+vC65jzMbNVF
         tEsXcmnPpTAa3QVUJD32FF//Pg1g4gevmpCkZ1yefoMIWN5v+REmvah3AdmG/D+dGymO
         Bxsdhk6jm65mxARtwnE0bEkSP2wtpmStIe8jbE8HS/NLb/G7TJALBamlmv+UOJflfCsA
         mZcQ==
X-Gm-Message-State: AOJu0Ywsntj7hS43jpJWMJRCfIKBkOWhqBFbLxD0ll6RZtKcM/tnd4bX
	ssgfTANNUf0ni0U1G3L0ZFmkDOULzrvD0n4itjje2avq1onnTU8=
X-Gm-Gg: ASbGncsWRMA364dqc40KcFf3VCRFnKYAKWmY7UQR7xhhyCBNSu8qLpp/B/eCLNtvO7n
	Cynez/EbxjhJLFgLxlorFgzyaI+vrEJC8BS23MBzNZB5Xa8Vlec8YXt2XC9sqAbmpIRfnZiu8k4
	9+4WZPcEuqFSEn0wEwzV67XyQgcMy+rjcnKuXgbYAxmxMY73pNu1uGmRuI08hEWg0hpluKwTVS7
	gbW4Lff+cJhhgu5ozZpmVzzVVSdIEhkZFLhuT9p1MzbSX2FJVLfBoNxdxASEfntKNA0bjoTYS9e
	IRfSY5plwF60Kl8Ipbu6i5cyM6oNOY+Je4sVvinwtE+GI/cJWG+rPK+MtiFAcSEzMRewbLEq+bO
	AiA==
X-Google-Smtp-Source: AGHT+IH8h2pOxhahhvIXknguMOBmnbVzuhQnRiHWKfA/LQP5vnMGw6fbyQcQP/lGAul4hDK0qxUWaw==
X-Received: by 2002:a17:903:41d2:b0:22e:4a2e:8ae7 with SMTP id d9443c01a7336-22e85ce9b08mr67255535ad.22.1746720830887;
        Thu, 08 May 2025 09:13:50 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22fc7743b8esm1096745ad.101.2025.05.08.09.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 09:13:50 -0700 (PDT)
Date: Thu, 8 May 2025 09:13:49 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jan Stancek <jstancek@redhat.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [PATCH net] tools/net/ynl: ethtool: fix crash when Hardware
 Clock info is missing
Message-ID: <aBzYPU32tTu8_hXk@mini-arch>
References: <20250508035414.82974-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250508035414.82974-1-liuhangbin@gmail.com>

On 05/08, Hangbin Liu wrote:
> Fix a crash in the ethtool YNL implementation when Hardware Clock information
> is not present in the response. This ensures graceful handling of devices or
> drivers that do not provide this optional field. e.g.
> 
>   Traceback (most recent call last):
>     File "/net/tools/net/ynl/pyynl/./ethtool.py", line 438, in <module>
>       main()
>       ~~~~^^
>     File "/net/tools/net/ynl/pyynl/./ethtool.py", line 341, in main
>       print(f'PTP Hardware Clock: {tsinfo["phc-index"]}')
>                                    ~~~~~~^^^^^^^^^^^^^
>   KeyError: 'phc-index'
> 
> Fixes: f3d07b02b2b8 ("tools: ynl: ethtool testing tool")
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

