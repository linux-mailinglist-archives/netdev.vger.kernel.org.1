Return-Path: <netdev+bounces-68506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DB08470C5
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 14:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4B971C224EA
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 13:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29986187F;
	Fri,  2 Feb 2024 13:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MqptBTdZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F9C1872
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 13:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706878893; cv=none; b=PnIRprANSihMDI8a6BvKVXH2FoO2ntjS2WQZtOAV6DKqLsPJym+51BesQoNBgTQeTbwli4+aEpuU3fITY7a8m0TDKUnf62QLVmns57oBIkVkEu1cnC0ldb3PCsAEAPv5PVzRED+WG/IOwMn+gIZh+ifGZFCG1GSe+J9W3DYVs8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706878893; c=relaxed/simple;
	bh=YAFCuyvbPRmINWjdMgxqeacoT9WT/QyG8j0uguQxuiA=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=U2o5UKFU3Z/yQ/HIQ22LmY27Vql8m0SHbTjoAPmeUGrMOI0vQx67jOMXcyIo98YOZ1GeHuzxAVnoGfwOIP0AZxx2yl6ZIQjtVihKrft2zWwJoHOvXGoToy5JNlmoM9n3YIm8uc3X9UDH1uv+KI0Po0TlOOK4niw0LytODWM4Mlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MqptBTdZ; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7c064c20ad4so4444539f.0
        for <netdev@vger.kernel.org>; Fri, 02 Feb 2024 05:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706878890; x=1707483690; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:msip_labels:content-language
         :accept-language:message-id:date:thread-index:thread-topic:subject
         :cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YAFCuyvbPRmINWjdMgxqeacoT9WT/QyG8j0uguQxuiA=;
        b=MqptBTdZkRNDTtbFLzDFD9ndV4gS/18qSFgmYpqj9GYJd4knd4dyyqKhrOhnoi2Gm7
         btbpnDJYqSczVcKeMtEa7nj+EAeIofnH/KWCQ83uTduYeZHCDxTZmId1xQCNI1ZxxuLu
         xPD1XXruyU0rLhQPS5ezoIk3TN4ycGrzPTB5tm8jcngA2VBPhjsHEGzZP0QIMR4zVYXO
         SN0c/kR4b/bVyV+p7kisrWl3MwR21zDSRlitzjsQ+2hhyHMvz0kaTdW5x0MZ3wq2q02+
         CqEcjAoNtV0q8SS99+BluUQcMYnXiEB16pnVagd6WREjay4MV4WkZfEUubM3W5MvWvZv
         0NLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706878890; x=1707483690;
        h=mime-version:content-transfer-encoding:msip_labels:content-language
         :accept-language:message-id:date:thread-index:thread-topic:subject
         :cc:to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YAFCuyvbPRmINWjdMgxqeacoT9WT/QyG8j0uguQxuiA=;
        b=FjWrF0zN+OTqSJosoj8YK71VMrZXbxvsnN6/Y1B49oqc6Zqim66pWQc948SJSWgmMJ
         riKLasVIXV44B/8tdr6T23/fD10aKgczfMeVanrelwY93Lp9k8hypI3fNEq2OV+ZfSWP
         zqTxyNhsvpVaS5NtGKRZ3J6W2P9P0LyePwq7WA1wpibGfUq9VB4aIe58z1MsRNGbYeSB
         w0racsQWnk+TIOG3Wd6bQ1x67OFz0PAdH+MW7xzC1z5o+t+ByNk6ujyjd5VL/V1s5mtD
         xjQ/rZEPyaD45HlNZBKyaJqn8LSRopm0CN+K0QNKA8ERbB54jT1OfoUeXLdwTrxWosDT
         flxA==
X-Gm-Message-State: AOJu0YyNGMkrlK8wfVYIY7Bmb3Ap9a/tNBAXU2Z+4Bg/xylYm47SdcD1
	VTcviIGhQ6rmfIr1xXC8dlvqVDQuro/HqtmYO/HNg0UYq+sHl/+noU0grzAVn6fG2wj5
X-Google-Smtp-Source: AGHT+IH37+TNu6Uklg6MWXOxxu4bGCM5PLeoBhNR9P8NR0gWNIMeP2GUgboSGu2unXIpuLfU1F8mog==
X-Received: by 2002:a6b:6812:0:b0:7bf:e164:e4f1 with SMTP id d18-20020a6b6812000000b007bfe164e4f1mr1867615ioc.2.1706878889874;
        Fri, 02 Feb 2024 05:01:29 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXsxBGGCYFaEx5Dvxh7E28SzxmqfGYsknqtRmMDFp4ROAA9pilhPZVuLFhUuVYFDWosJqtAVVr7JoXHKgqm90Ir7e57sHztsqhFYM/J1LlLbFOyEtvv9zmjF2CGxCkGgBRsWAqo5TFhdzE8saMtclVFyUD+sH3gIWLJNZ8TYVT0mG5JUb1rRPEj9pzDIn/Rz8aerHRKplHQ+Xol6s/TA60/I8sJ/oqKyyvsNUXlTAO4LI48Lg==
Received: from AS2PR09MB6293.eurprd09.prod.outlook.com ([2603:1026:c03:7417::5])
        by smtp.gmail.com with ESMTPSA id m1-20020a056638260100b0047113191901sm25133jat.110.2024.02.02.05.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 05:01:29 -0800 (PST)
From: =?koi8-r?B?4c7UwdLJzyDw0s/T0MXSzw==?= <jansaley@gmail.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "a@unstable.cc" <a@unstable.cc>, "davem@davemloft.net"
	<davem@davemloft.net>, "dsahern@kernel.org" <dsahern@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"thomas.winter@alliedtelesis.co.nz" <thomas.winter@alliedtelesis.co.nz>
Subject: Re: [BUG] gre interface incorrectly generates link-local addresses
Thread-Topic: [BUG] gre interface incorrectly generates link-local addresses
Thread-Index: AQHaVCrRZ+x1H873S0iWHD4uCDBUpQ==
X-MS-Exchange-MessageSentRepresentingType: 1
Date: Fri, 2 Feb 2024 13:01:26 +0000
Message-ID:
	<AS2PR09MB6293D2C85ABD5029AB9C69DAF37C2@AS2PR09MB6293.eurprd09.prod.outlook.com>
Accept-Language: ru-RU, en-US
Content-Language: ru-RU
X-MS-Has-Attach:
X-MS-Exchange-Organization-SCL: -1
X-MS-TNEF-Correlator:
X-MS-Exchange-Organization-RecordReviewCfmType: 0
msip_labels:
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hell=0A=
I want to bring up this topic again=0A=
Is it possible to use the addr_gen_mode parameter for GRE in the current ve=
rsion of addrconf?=0A=
There was an edit in the e5dd729460ca commit that dev->interface type shoul=
d be equal to ARPHRD_ETHER, then addrconf_addr_gen will be called.=0A=
But doesn't this contradict the fact that before calling the addrconf_gre_c=
onfig function, there is a check that dev->type should be equal to ARPHRD_I=
PGRE or ARPHRD_IP6GRE?=

