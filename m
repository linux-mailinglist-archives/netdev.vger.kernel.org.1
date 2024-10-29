Return-Path: <netdev+bounces-140141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E9B9B5572
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 23:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E871282791
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 22:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C36209684;
	Tue, 29 Oct 2024 22:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JsxXrNIz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CEE2010F8;
	Tue, 29 Oct 2024 22:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730239366; cv=none; b=m7JUo47usKJ3hLtHOVhIwlIuLQeRLgpi8UA3t5LFZkRytC/vU8Nxa2s+z1IJBXzIbMgfOyzcUigeZpyTaIg03z32RmcUye9lLKhUH1bAMnsxpm/cb38386I/7SaLt4IFvcTbbPkkWnYDN3a4wcXBcxj9eqyC7hI9vosYLgTJhOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730239366; c=relaxed/simple;
	bh=2mFz11bqCGFieIYuz0RGGGoLwhZ9b/4uIL7UXwO7yPk=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=iNbEgPU2yq860f5YQfFaeYnAYCV10xGX4pMN93smnZ+7rKrN91CFdV0IJ/ke+F/DZ/G4F9UbAPBLuwmFj2fX4/FPXzGIbKeZzoOO5jLQk0tZdiZBLZHEcGOzspxKOgViXHFM1tLabtii8PCSE8lGRha8IxKD1R5OyMdHIHfj/U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JsxXrNIz; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37d3ecad390so174833f8f.1;
        Tue, 29 Oct 2024 15:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730239363; x=1730844163; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D6cWA38RYQ7ioG9FHGdS8JCnTCdCX0FssCcBgsyIIKw=;
        b=JsxXrNIzdgBkxJmrP446TDoIluvoZ/j/OLAYGmfLAtMWmEp9j7H8Fb+pViG43UQgnX
         /5y/y9B7cDI6ZBQXEbCdmasV8TkNqX2np3sBiJ/fqmon/tirbzo1IMDBoR9G5Iebn/3f
         c3etGFoAHd39d1T2muSRtcn9G7CeZ9ehQl14YFkInCx3amifHTNIEo3vrMthrFqA6IlH
         60H/zU3hv8vFIKApMZ9cM9KUffb5lNNz7xke1j9dak4ZCek5XmOdp9cTdsQsgGy36D1r
         4c/LnSBxYWUeBHfIAaeD+K/7CCruuQU7+SHDmFRhmS5/RV5hSomATtyJO/QJo2mCLZLs
         vIZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730239363; x=1730844163;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=D6cWA38RYQ7ioG9FHGdS8JCnTCdCX0FssCcBgsyIIKw=;
        b=w3D0dsuoLZS/0tb6Yt99jCpMNAM9a7qzFTSRI4BeygiZofkFHMcm1yK+2QSMla5ryH
         fSdR2PXJUjkc8hKOf+PUBA9a4UcdQdM2S1w3Uab2+BqcB42/fIX74Dg7a5LMd68TTFwl
         uslBSxI1k8faYeS2AwH+KPJN5VHloE9CTspJHtAU0LkBbYDh/VPV3CpAuTEN2TOmX2Zv
         mtglLj0VfEK0vvaDcR5WH2rtcP4aIQJKGO2oqVecw6TfS2kIAXX7Knw+24sho9we63O3
         TIW+TeuiBOMoQGdmcnaDPR8+EUMQ6GZ7+Qvgf89At94tVyTSJB9QFTGjKw5PIsx+DNGV
         /Yrg==
X-Forwarded-Encrypted: i=1; AJvYcCUQz537dnsuDiMfmKMaP4ZhMRGHbSAyEAb9mFabXqidhgsCMqZCJ1KJ9vji3dYqBJ92th8BZy8sHL3pvxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuC6MVgRiCSi4j3spvz/wM5p0aszI/Ov4EWY2A5b+ydlNoiPee
	dhoick2uEu4Vo0vDVKq3c18U+uRIA6GktRrv22M9PSam8MMvbjQS
X-Google-Smtp-Source: AGHT+IH5/3A72iQ1divV7ObVOv8TB3W/VyfYBE21qgPA79ig620Mt8TlNACI2iIbNoEDsq0yPGqtlw==
X-Received: by 2002:adf:ea43:0:b0:37c:ffdd:6d5a with SMTP id ffacd0b85a97d-38173e619c6mr3767272f8f.6.1730239362892;
        Tue, 29 Oct 2024 15:02:42 -0700 (PDT)
Received: from [192.168.1.248] ([194.120.133.34])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38058b3bdafsm13629983f8f.30.2024.10.29.15.02.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2024 15:02:42 -0700 (PDT)
Message-ID: <cf40ac34-1655-4eee-85dc-c836e77eb301@gmail.com>
Date: Tue, 29 Oct 2024 22:02:41 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: "Colin King (gmail)" <colin.i.king@gmail.com>
Subject: net: ethernet: starfire: while loop that is never executed
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

There is a while-loop in function set_vlan_mode in source 
drivers/net/ethernet/adaptec/starfire.c that currently never gets 
executed, the code is as follows:

         for_each_set_bit(vid, np->active_vlans, VLAN_N_VID) {
                 if (vlan_count == 32)
                         break;
                 writew(vid, filter_addr);
                 filter_addr += 16;
                 vlan_count++;
         }
         if (vlan_count == 32) {
                 ret |= PerfectFilterVlan;
                 while (vlan_count < 32) {
                         writew(0, filter_addr);
                         filter_addr += 16;
                         vlan_count++;
                 }
         }
         return ret;

the while (vlan_count < 32) loop will never get executed because the 
outer if statement is only executed if val_count is equal to 32 hence 
val_count < 32 will be false. I'm assuming the while loop is filing the 
unused slots with zero, so I suspect the code should be:

          if (vlan_count == 32)
                 ret |= PerfectFilterVlan;

          while (vlan_count < 32) {
                 writew(0, filter_addr);
                 filter_addr += 16;
                 vlan_count++;
          }

..however I can't find any info on this H/W and I can't test it, so I'm 
not confident my assumption here is correct.

Colin



