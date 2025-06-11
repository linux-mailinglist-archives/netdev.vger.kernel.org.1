Return-Path: <netdev+bounces-196561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44EDBAD550B
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 14:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F8133AC147
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 12:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC112797B1;
	Wed, 11 Jun 2025 12:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GzGG9wLT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572D627C144
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 12:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749643693; cv=none; b=Jvy+U4yio+ArQIHju96QGLlHEdmP3D69HfYc9VWGH2g2eG8huQOZSB9uWgPecRIiDrFzo+elLjS7g11tCvLnOcAw3cqHF4yDzInOvShic8QdZxqr4tdJUPfQ+w1K/DfAfHHz+rzX62Oduj2oHHJnhButBAEvpmfhWmOVL3HZQmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749643693; c=relaxed/simple;
	bh=Khui5tXJv7xgVrpuQKD+sMbOIS8H4AFypNM01pSW7kE=;
	h=From:Message-ID:Date:MIME-Version:To:Cc:Subject:Content-Type; b=j/sV83snXyx9CJFsSpI4dvmu8ChnAPH8eCp0kXAiVbMBKbeqem6/yabUREBYBCAC/fK1NC4YOUpXsvwWCgnoyE7Xhx+3eMOLZhACXE1v6KFw7MEVjVksdHBlp6eCMFLt8PgpnnfauaIMIrPg7JCJmxfgR2iUnd9uivUBs1th6vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GzGG9wLT; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-addda47ebeaso1266390266b.1
        for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 05:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749643690; x=1750248490; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:subject:cc:content-language
         :to:user-agent:mime-version:date:message-id:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tYgscvI8A27Df3EgErBaH87ZwifmujEIc1F7LwYSsYM=;
        b=GzGG9wLTX/Iv9hYKzEVYMBVO/+bp+ku2LZq++W+UloXYsNiCxTxQIVrANv5nxd4vLC
         aCTBFz7ycXxFtaaBg7HVjE/rkdZgqnc2mKUXFCdCkOpqJcNcCwvriVahM17IO9Evkr0K
         2Fnck9oxwdsnNuZKEUomapgxNAT4akjAIVqbtTD/0n6WXkVvh+iayiYeSlhfmZp3eXCE
         RDdQNT8/w0SMdjMK6rVB7DP3Q8gU5KZxYmxYivm56JZSGPUvGEgPbgVAUQ6m/OhovaUT
         wVLoyiYWhq4hE4FybfhB5vyJz13AM/mVCbC5gDPLzWT7ufwF5MLzaMLc5fBvAKL3zyn4
         J8FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749643690; x=1750248490;
        h=content-transfer-encoding:organization:subject:cc:content-language
         :to:user-agent:mime-version:date:message-id:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tYgscvI8A27Df3EgErBaH87ZwifmujEIc1F7LwYSsYM=;
        b=gb5nEWMCFKOHYYFdSivzSY8Whrtf3fklIcO2qVxnVi+MQFs9js4nNrjCe6IOppMDq4
         47j7y4x2+/eYIpu8iwFDRx0yHwv4aYJGGRMeJL7l9nceMJi6Wb4gd7bhn+Upn9o2nr9C
         3nJZP/mb0dCNS2oEojPlNS/Pba+kdzWj+7fXBbbgyK/nCVU2sfjCxl0qkySkPlBHFZUM
         ZId2V6Lx3prgYC80kHjWMw4HuumWXSlnBMNCsCIQSPYXDZZh3CsYR/NjI/X3s9AnZQgy
         0lcOz9rQpvWUlcyZ2MSd1E/4aF+67fGqKolzvIQddaLkK5qIHhh8oJCVVp1+6YGVPQ92
         EoNg==
X-Gm-Message-State: AOJu0YyyNxxoaO+DxvPyzJir5Dr0vGfEjQtTM3eFdcp6xhDr0FKnsYhx
	uUM5deWcinRw9JthSMS4JWGEfxmAzdtKWAyIkavm3pODKxFyg4IyOCFE
X-Gm-Gg: ASbGncvPFcXXWtuRxmOmu9H809AAEJholjGMLpbuhjellrg7nhLGz0r0bjr5aRHxy6r
	4olb36oGeTVTFFsLRQJSmQ/h4yxDgdvpXDvIyglu9/Uj5mjW6JBqD4oaWJey8vjpVJYEg+qVGEI
	wpZj3rqfOl2dwcHlAPZh0BOqj5DEu91TeXeRddLCwRMUwCkWB+aolhh4wEBVoPkoTpCgwLnTFyR
	Zk4uJ/fAk18xLNx3k7zWodngUBoCTJc5icM/hPkIlMkpLZ44v4XSKI1RNqipJS55AR0+0TlvghC
	fS6NN5gdWr8Rnvh27LEcPwB2UVEwKV1c6ym2730ReN8QnfkwoNJl6q7VwWNMf1nQRGgRtjyalQ=
	=
X-Google-Smtp-Source: AGHT+IFLq1CJGOffWnqrXOBQLQCdf8fWQEKH54nQowr5fBPk0MXhe4KP46r9QygkPNRgvAEWSeNTig==
X-Received: by 2002:a17:906:fe08:b0:ad8:8689:2cc9 with SMTP id a640c23a62f3a-ade8c93930emr239952366b.56.1749643689307;
        Wed, 11 Jun 2025 05:08:09 -0700 (PDT)
Received: from [127.0.0.1] ([193.252.113.11])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade1dc1c7e2sm875615466b.73.2025.06.11.05.08.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jun 2025 05:08:08 -0700 (PDT)
From: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
X-Google-Original-From: Alexandre Ferrieux <alexandre.ferrieux@orange.com>
Message-ID: <4c0389de-1e74-46f8-9ce8-4927241fd35c@orange.com>
Date: Wed, 11 Jun 2025 14:08:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daniel Borkmann <daniel@iogearbox.net>
Content-Language: fr, en-US
Cc: Linux Kernel Network Developers <netdev@vger.kernel.org>,
 Nicolas Dichtel <nicolas.dichtel@6wind.com>
Subject: [BUG iproute2] Netkit unusable in batch mode
Organization: Orange
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Daniel,

Playing around with netkit to circumvent veth performance issues, I stumbled
upon a strange thing in iplink_netkit.c : the presence of three static variables
which tend to wreak havoc in case of multiple netlink commands in batch mode (ip
-b) : "seen_mode", "seen_peer", and "data".

As a consequence, the following simple batch sequence systematically fails:

    # ip -b - <<EOF
    link add a1 type netkit peer a2
    link add b1 type netkit peer b2
    EOF
    *    Error: duplicate "peer": "b2" is the second value.*

While the patch below solves the problem, I wonder: why in the first place are
these three locals declared static ? Is there a scenario where
netkit_parse_opt() is called several times in a single command, but in a
stateful manner ?

Thanks for any clarification

-Alex

-----

diff --git a/ip/iplink_netkit.c b/ip/iplink_netkit.c
index 818da119..de1681b9 100644
--- a/ip/iplink_netkit.c
+++ b/ip/iplink_netkit.c
@@ -48,8 +48,8 @@ static int netkit_parse_opt(struct link_util *lu, int argc,
char **argv,
 {
        __u32 ifi_flags, ifi_change, ifi_index;
        struct ifinfomsg *ifm, *peer_ifm;
-       static bool seen_mode, seen_peer;
-       static struct rtattr *data;
+       bool seen_mode=false, seen_peer=false;
+       struct rtattr *data=NULL;
        int err;

        ifm = NLMSG_DATA(n);


