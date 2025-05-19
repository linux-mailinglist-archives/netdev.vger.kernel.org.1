Return-Path: <netdev+bounces-191555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79137ABC197
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 17:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D853C1888199
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 15:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78DD6283CB8;
	Mon, 19 May 2025 15:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deepl.com header.i=@deepl.com header.b="dmJEGk5F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C251D5AD4
	for <netdev@vger.kernel.org>; Mon, 19 May 2025 15:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747667040; cv=none; b=M1/52A7ONFxGHeo6FU9hU3QULd5ckfqgwiU0UVSq2Efk/dpVtUhJbyp2Ph5VabJk1vIB1iRNFuiVsKpm9I6imWCwuk70e1Afxz/QlbU4/pN0UbLfCmdoacUczoLtKmH1n5zF6/5kmiRzvyFe3fGN3tn+ihO8g+AwDFNJCccmk6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747667040; c=relaxed/simple;
	bh=O0FdxPus7FO7XzzEUv/LEle1JqBQyrcPCM+87CXvSgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dzFO4E0bF02d5ZUHVyGiCXhwF0Dz1O5w+zFlG/n0rXCPls5ZwjZWqUxhrxrlLnfXXODeiSG4Y10mpOIgf9OrtKIovQW8DZt69Y/f2RSS40wH9dY/bJkLWBLbvQZFo5LVshgCOT7mk7VntCiYBiEIKaJre8RjfbfhmV5r5Dzerq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=deepl.com; spf=pass smtp.mailfrom=deepl.com; dkim=pass (2048-bit key) header.d=deepl.com header.i=@deepl.com header.b=dmJEGk5F; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=deepl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deepl.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-329157c9f79so5735991fa.1
        for <netdev@vger.kernel.org>; Mon, 19 May 2025 08:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deepl.com; s=google; t=1747667034; x=1748271834; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wLn+7y8ZZKDVRNFoei6bc2ETBOjWC8JfZludgciJSLY=;
        b=dmJEGk5F9NvpO+gP1knblHOEkyGGlP2MZppKgoAguYQmEfgB1Ax4z1GbendZR+TLhV
         lQPGX4K8Oiy+IVbdDS9X/fXIteGx9EoSW45FFUY2DCxRsaF8bBScEPZvK7cbRu3mMdCZ
         jRiBXeiF1BvsgEKDaP9HTPuNxEjRKphIvwUdfJoAT10xO/2K30EJrK+J70HJUkmWq4G/
         OkuzR7F1bGQZXEVy+6Pb1YULGUtmyiIqDxPw8Vw2nWIPZ9lsXwiZ99nXH3VMxEUUMyuU
         wVYymS5LbMCjRZbwm7Gwt1Rzgyh+UBeP8JNPpzdg6vmL7QsRK3Mt7/EhGBGbdrriwgAU
         Q6kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747667034; x=1748271834;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wLn+7y8ZZKDVRNFoei6bc2ETBOjWC8JfZludgciJSLY=;
        b=PympP3GpWw7sE1Vjw4j9PZzHRjntjM3k6mV0NvdRSHX6MGXA4e+mR2rzBngAIwKPDZ
         6ZESPUWYlrFqiuilRp/7V9LREXNMW42wHsur03HiirjK1LQ6uJ/Aaz/7ZcyNU40dQHdl
         s4viHk5UW1NruDKkAggv2Ahm3+9KRAvoe/Tg7bfWcFQXpn6iy5ZIxvCGal6UQln6+4wq
         H32fBgS/6GWbB9t6M+EmMd06guj0N2p89WjrcREt6nqMvsFdg3e7NGBvGCxdzadEfyPa
         iYloQ+++yazQSrZEVpqjavnAPPaGUpMrQFmOXY0/djrOvrba7r6iHIy0KVFNQLTV6HK+
         fBjw==
X-Gm-Message-State: AOJu0YwHcyHhwkc8RiLDmkwqbn+xkLJxQ3Apm1MaAsiiI32IXMOig+c9
	PX4uig2SHrmMTj/DwHVLL1i2kG7Bk7Coq0IA6Ym3YasvQbZLhHY3oyTyQ9/RK4hvRDkDcN34irl
	Z0k+M05rwu4q6qtOVl/ZYf7ZDn3aSDwwEKZg9tr7yajl42kzz1GLSPYL/wg==
X-Gm-Gg: ASbGncu4QoUo/HuAP5/s4OxbTgwzOFEy+tE0a72NqWTqnXLS3Y0DPDEoWnrMc9t7ehT
	oZz1/yMIiy8w508KbJGNzVY/5qfb8b/Q6IBWI3AXYBGlr6FlUm0RK41deFNyX3buzFccvJOynXK
	XMr7PzmoDKtlTAvKlWmi9qajtoA5ITrOdJpJii0T9gCujQYBs9GSC10wnPt70XG2CcJJUb7jkuT
	8HsSA==
X-Google-Smtp-Source: AGHT+IGefc2+6xvIKyk33Gl5xva/66vPe0ORp92S1/OACtZ1nxcjdN0ZuY9J7y9l3Bqmy1qsT7cDvTX0L+KtaoDNYBE=
X-Received: by 2002:a05:651c:4181:b0:30c:467f:cda2 with SMTP id
 38308e7fff4ca-328076fe56amr32321241fa.10.1747667032210; Mon, 19 May 2025
 08:03:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAHxn9-ctPXJh1jeZc3bYeNod6pdfd6qgYWuXMb9uN_12McPAQ@mail.gmail.com>
 <CADVnQy=RRLaTG4t5BqQ1XJskb+oxWe=M_qY0u9rzmXGS1+b7nQ@mail.gmail.com>
In-Reply-To: <CADVnQy=RRLaTG4t5BqQ1XJskb+oxWe=M_qY0u9rzmXGS1+b7nQ@mail.gmail.com>
From: Simon Campion <simon.campion@deepl.com>
Date: Mon, 19 May 2025 17:03:40 +0200
X-Gm-Features: AX0GCFs-mjzJFPciPzQ_MXiZ5ULeN_abzBBj1nKRtr4wRrAufwjNui8hFik0WHk
Message-ID: <CAAHxn98G9kKtVi34mC+NHwasixZd63C8+s5gC5T5o-vKUVVoKQ@mail.gmail.com>
Subject: Re: [EXT] Re: tcp: socket stuck with zero receive window after SACK
To: Neal Cardwell <ncardwell@google.com>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Yuchung Cheng <ycheng@google.com>, Kevin Yang <yyd@google.com>
Content-Type: multipart/mixed; boundary="000000000000a4399406357e7027"

--000000000000a4399406357e7027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Gladly! I attached the output of nstat -az. I ran it twice, right
before a 602 byte retransmit was received and dropped, and right
after, in case looking at the diff is helpful.

Here's the first run:

#kernel
IpInReceives                    18788097214        0.0
IpInHdrErrors                   47522              0.0
IpInAddrErrors                  0                  0.0
IpForwDatagrams                 11778747           0.0
IpInUnknownProtos               0                  0.0
IpInDiscards                    0                  0.0
IpInDelivers                    18776248435        0.0
IpOutRequests                   14428799907        0.0
IpOutDiscards                   40798              0.0
IpOutNoRoutes                   0                  0.0
IpReasmTimeout                  0                  0.0
IpReasmReqds                    32952              0.0
IpReasmOKs                      16476              0.0
IpReasmFails                    0                  0.0
IpFragOKs                       0                  0.0
IpFragFails                     0                  0.0
IpFragCreates                   0                  0.0
IpOutTransmits                  14440537900        0.0
IcmpInMsgs                      7052154            0.0
IcmpInErrors                    107                0.0
IcmpInCsumErrors                0                  0.0
IcmpInDestUnreachs              100237             0.0
IcmpInTimeExcds                 298                0.0
IcmpInParmProbs                 0                  0.0
IcmpInSrcQuenchs                0                  0.0
IcmpInRedirects                 67                 0.0
IcmpInEchos                     4035849            0.0
IcmpInEchoReps                  2915703            0.0
IcmpInTimestamps                0                  0.0
IcmpInTimestampReps             0                  0.0
IcmpInAddrMasks                 0                  0.0
IcmpInAddrMaskReps              0                  0.0
IcmpOutMsgs                     7061967            0.0
IcmpOutErrors                   0                  0.0
IcmpOutRateLimitGlobal          0                  0.0
IcmpOutRateLimitHost            47087              0.0
IcmpOutDestUnreachs             10421              0.0
IcmpOutTimeExcds                449                0.0
IcmpOutParmProbs                0                  0.0
IcmpOutSrcQuenchs               0                  0.0
IcmpOutRedirects                46216              0.0
IcmpOutEchos                    2969032            0.0
IcmpOutEchoReps                 4035849            0.0
IcmpOutTimestamps               0                  0.0
IcmpOutTimestampReps            0                  0.0
IcmpOutAddrMasks                0                  0.0
IcmpOutAddrMaskReps             0                  0.0
IcmpMsgInType0                  2915703            0.0
IcmpMsgInType3                  100237             0.0
IcmpMsgInType5                  67                 0.0
IcmpMsgInType8                  4035849            0.0
IcmpMsgInType11                 298                0.0
IcmpMsgOutType0                 4035849            0.0
IcmpMsgOutType3                 10421              0.0
IcmpMsgOutType5                 46216              0.0
IcmpMsgOutType8                 2969032            0.0
IcmpMsgOutType11                449                0.0
TcpActiveOpens                  7902932            0.0
TcpPassiveOpens                 1447146            0.0
TcpAttemptFails                 41605              0.0
TcpEstabResets                  1327046            0.0
TcpInSegs                       4953075475         0.0
TcpOutSegs                      2988066928         0.0
TcpRetransSegs                  656187             0.0
TcpInErrs                       0                  0.0
TcpOutRsts                      3401866            0.0
TcpInCsumErrors                 0                  0.0
UdpInDatagrams                  13816173054        0.0
UdpNoPorts                      10435              0.0
UdpInErrors                     2                  0.0
UdpOutDatagrams                 493212273          0.0
UdpRcvbufErrors                 0                  0.0
UdpSndbufErrors                 10                 0.0
UdpInCsumErrors                 0                  0.0
UdpIgnoredMulti                 0                  0.0
UdpMemErrors                    0                  0.0
UdpLiteInDatagrams              0                  0.0
UdpLiteNoPorts                  0                  0.0
UdpLiteInErrors                 0                  0.0
UdpLiteOutDatagrams             0                  0.0
UdpLiteRcvbufErrors             0                  0.0
UdpLiteSndbufErrors             0                  0.0
UdpLiteInCsumErrors             0                  0.0
UdpLiteIgnoredMulti             0                  0.0
UdpLiteMemErrors                0                  0.0
Ip6InReceives                   268280             0.0
Ip6InHdrErrors                  0                  0.0
Ip6InTooBigErrors               0                  0.0
Ip6InNoRoutes                   39                 0.0
Ip6InAddrErrors                 0                  0.0
Ip6InUnknownProtos              0                  0.0
Ip6InTruncatedPkts              0                  0.0
Ip6InDiscards                   0                  0.0
Ip6InDelivers                   85862              0.0
Ip6OutForwDatagrams             0                  0.0
Ip6OutRequests                  500197             0.0
Ip6OutDiscards                  1                  0.0
Ip6OutNoRoutes                  591                0.0
Ip6ReasmTimeout                 0                  0.0
Ip6ReasmReqds                   0                  0.0
Ip6ReasmOKs                     0                  0.0
Ip6ReasmFails                   0                  0.0
Ip6FragOKs                      0                  0.0
Ip6FragFails                    0                  0.0
Ip6FragCreates                  0                  0.0
Ip6InMcastPkts                  194727             0.0
Ip6OutMcastPkts                 426562             0.0
Ip6InOctets                     20173005           0.0
Ip6OutOctets                    45359068           0.0
Ip6InMcastOctets                14345494           0.0
Ip6OutMcastOctets               39440790           0.0
Ip6InBcastOctets                0                  0.0
Ip6OutBcastOctets               0                  0.0
Ip6InNoECTPkts                  268280             0.0
Ip6InECT1Pkts                   0                  0.0
Ip6InECT0Pkts                   0                  0.0
Ip6InCEPkts                     0                  0.0
Ip6OutTransmits                 500197             0.0
Icmp6InMsgs                     23176              0.0
Icmp6InErrors                   0                  0.0
Icmp6OutMsgs                    437389             0.0
Icmp6OutErrors                  0                  0.0
Icmp6InCsumErrors               0                  0.0
Icmp6OutRateLimitHost           0                  0.0
Icmp6InDestUnreachs             0                  0.0
Icmp6InPktTooBigs               0                  0.0
Icmp6InTimeExcds                0                  0.0
Icmp6InParmProblems             0                  0.0
Icmp6InEchos                    0                  0.0
Icmp6InEchoReplies              0                  0.0
Icmp6InGroupMembQueries         0                  0.0
Icmp6InGroupMembResponses       0                  0.0
Icmp6InGroupMembReductions      0                  0.0
Icmp6InRouterSolicits           12339              0.0
Icmp6InRouterAdvertisements     0                  0.0
Icmp6InNeighborSolicits         2117               0.0
Icmp6InNeighborAdvertisements   8720               0.0
Icmp6InRedirects                0                  0.0
Icmp6InMLDv2Reports             0                  0.0
Icmp6OutDestUnreachs            0                  0.0
Icmp6OutPktTooBigs              0                  0.0
Icmp6OutTimeExcds               0                  0.0
Icmp6OutParmProblems            0                  0.0
Icmp6OutEchos                   0                  0.0
Icmp6OutEchoReplies             0                  0.0
Icmp6OutGroupMembQueries        0                  0.0
Icmp6OutGroupMembResponses      0                  0.0
Icmp6OutGroupMembReductions     0                  0.0
Icmp6OutRouterSolicits          2                  0.0
Icmp6OutRouterAdvertisements    0                  0.0
Icmp6OutNeighborSolicits        69476              0.0
Icmp6OutNeighborAdvertisements  2116               0.0
Icmp6OutRedirects               0                  0.0
Icmp6OutMLDv2Reports            365795             0.0
Icmp6InType133                  12339              0.0
Icmp6InType135                  2117               0.0
Icmp6InType136                  8720               0.0
Icmp6OutType133                 2                  0.0
Icmp6OutType135                 69476              0.0
Icmp6OutType136                 2116               0.0
Icmp6OutType143                 365795             0.0
Udp6InDatagrams                 6                  0.0
Udp6NoPorts                     0                  0.0
Udp6InErrors                    0                  0.0
Udp6OutDatagrams                6                  0.0
Udp6RcvbufErrors                0                  0.0
Udp6SndbufErrors                0                  0.0
Udp6InCsumErrors                0                  0.0
Udp6IgnoredMulti                0                  0.0
Udp6MemErrors                   0                  0.0
UdpLite6InDatagrams             0                  0.0
UdpLite6NoPorts                 0                  0.0
UdpLite6InErrors                0                  0.0
UdpLite6OutDatagrams            0                  0.0
UdpLite6RcvbufErrors            0                  0.0
UdpLite6SndbufErrors            0                  0.0
UdpLite6InCsumErrors            0                  0.0
UdpLite6MemErrors               0                  0.0
TcpExtSyncookiesSent            0                  0.0
TcpExtSyncookiesRecv            0                  0.0
TcpExtSyncookiesFailed          0                  0.0
TcpExtEmbryonicRsts             3                  0.0
TcpExtPruneCalled               3891               0.0
TcpExtRcvPruned                 0                  0.0
TcpExtOfoPruned                 0                  0.0
TcpExtOutOfWindowIcmps          10                 0.0
TcpExtLockDroppedIcmps          178                0.0
TcpExtArpFilter                 0                  0.0
TcpExtTW                        3583160            0.0
TcpExtTWRecycled                4217               0.0
TcpExtTWKilled                  0                  0.0
TcpExtPAWSActive                0                  0.0
TcpExtPAWSEstab                 60                 0.0
TcpExtDelayedACKs               5133416            0.0
TcpExtDelayedACKLocked          3008               0.0
TcpExtDelayedACKLost            111165             0.0
TcpExtListenOverflows           0                  0.0
TcpExtListenDrops               0                  0.0
TcpExtTCPHPHits                 2023413            0.0
TcpExtTCPPureAcks               53087713           0.0
TcpExtTCPHPAcks                 115340211          0.0
TcpExtTCPRenoRecovery           0                  0.0
TcpExtTCPSackRecovery           13396              0.0
TcpExtTCPSACKReneging           0                  0.0
TcpExtTCPSACKReorder            202                0.0
TcpExtTCPRenoReorder            0                  0.0
TcpExtTCPTSReorder              1                  0.0
TcpExtTCPFullUndo               0                  0.0
TcpExtTCPPartialUndo            1                  0.0
TcpExtTCPDSACKUndo              252                0.0
TcpExtTCPLossUndo               85                 0.0
TcpExtTCPLostRetransmit         195718             0.0
TcpExtTCPRenoFailures           0                  0.0
TcpExtTCPSackFailures           3                  0.0
TcpExtTCPLossFailures           0                  0.0
TcpExtTCPFastRetrans            381976             0.0
TcpExtTCPSlowStartRetrans       76                 0.0
TcpExtTCPTimeouts               195387             0.0
TcpExtTCPLossProbes             110863             0.0
TcpExtTCPLossProbeRecovery      773                0.0
TcpExtTCPRenoRecoveryFail       0                  0.0
TcpExtTCPSackRecoveryFail       38                 0.0
TcpExtTCPRcvCollapsed           2960               0.0
TcpExtTCPBacklogCoalesce        252840759          0.0
TcpExtTCPDSACKOldSent           111216             0.0
TcpExtTCPDSACKOfoSent           2                  0.0
TcpExtTCPDSACKRecv              77523              0.0
TcpExtTCPDSACKOfoRecv           3                  0.0
TcpExtTCPAbortOnData            509577             0.0
TcpExtTCPAbortOnClose           1246626            0.0
TcpExtTCPAbortOnMemory          0                  0.0
TcpExtTCPAbortOnTimeout         32                 0.0
TcpExtTCPAbortOnLinger          0                  0.0
TcpExtTCPAbortFailed            0                  0.0
TcpExtTCPMemoryPressures        0                  0.0
TcpExtTCPMemoryPressuresChrono  0                  0.0
TcpExtTCPSACKDiscard            10                 0.0
TcpExtTCPDSACKIgnoredOld        2                  0.0
TcpExtTCPDSACKIgnoredNoUndo     73310              0.0
TcpExtTCPSpuriousRTOs           23                 0.0
TcpExtTCPMD5NotFound            0                  0.0
TcpExtTCPMD5Unexpected          0                  0.0
TcpExtTCPMD5Failure             0                  0.0
TcpExtTCPSackShifted            45975              0.0
TcpExtTCPSackMerged             248207             0.0
TcpExtTCPSackShiftFallback      328257             0.0
TcpExtTCPBacklogDrop            0                  0.0
TcpExtPFMemallocDrop            0                  0.0
TcpExtTCPMinTTLDrop             0                  0.0
TcpExtTCPDeferAcceptDrop        0                  0.0
TcpExtIPReversePathFilter       0                  0.0
TcpExtTCPTimeWaitOverflow       0                  0.0
TcpExtTCPReqQFullDoCookies      0                  0.0
TcpExtTCPReqQFullDrop           0                  0.0
TcpExtTCPRetransFail            55                 0.0
TcpExtTCPRcvCoalesce            1575181380         0.0
TcpExtTCPOFOQueue               2661363            0.0
TcpExtTCPOFODrop                0                  0.0
TcpExtTCPOFOMerge               2                  0.0
TcpExtTCPChallengeACK           138                0.0
TcpExtTCPSYNChallenge           87                 0.0
TcpExtTCPFastOpenActive         0                  0.0
TcpExtTCPFastOpenActiveFail     0                  0.0
TcpExtTCPFastOpenPassive        0                  0.0
TcpExtTCPFastOpenPassiveFail    0                  0.0
TcpExtTCPFastOpenListenOverflow 0                  0.0
TcpExtTCPFastOpenCookieReqd     0                  0.0
TcpExtTCPFastOpenBlackhole      0                  0.0
TcpExtTCPSpuriousRtxHostQueues  118                0.0
TcpExtBusyPollRxPackets         0                  0.0
TcpExtTCPAutoCorking            20400747           0.0
TcpExtTCPFromZeroWindowAdv      3612949            0.0
TcpExtTCPToZeroWindowAdv        3612953            0.0
TcpExtTCPWantZeroWindowAdv      0                  0.0
TcpExtTCPSynRetrans             194466             0.0
TcpExtTCPOrigDataSent           1261792021         0.0
TcpExtTCPHystartTrainDetect     40140              0.0
TcpExtTCPHystartTrainCwnd       4828784            0.0
TcpExtTCPHystartDelayDetect     17                 0.0
TcpExtTCPHystartDelayCwnd       8489               0.0
TcpExtTCPACKSkippedSynRecv      0                  0.0
TcpExtTCPACKSkippedPAWS         3                  0.0
TcpExtTCPACKSkippedSeq          580                0.0
TcpExtTCPACKSkippedFinWait2     0                  0.0
TcpExtTCPACKSkippedTimeWait     0                  0.0
TcpExtTCPACKSkippedChallenge    0                  0.0
TcpExtTCPWinProbe               0                  0.0
TcpExtTCPKeepAlive              2024725            0.0
TcpExtTCPMTUPFail               0                  0.0
TcpExtTCPMTUPSuccess            0                  0.0
TcpExtTCPDelivered              1269268682         0.0
TcpExtTCPDeliveredCE            0                  0.0
TcpExtTCPAckCompressed          1028306            0.0
TcpExtTCPZeroWindowDrop         485489             0.0
TcpExtTCPRcvQDrop               0                  0.0
TcpExtTCPWqueueTooBig           0                  0.0
TcpExtTCPFastOpenPassiveAltKey  0                  0.0
TcpExtTcpTimeoutRehash          195346             0.0
TcpExtTcpDuplicateDataRehash    53                 0.0
TcpExtTCPDSACKRecvSegs          77539              0.0
TcpExtTCPDSACKIgnoredDubious    12                 0.0
TcpExtTCPMigrateReqSuccess      0                  0.0
TcpExtTCPMigrateReqFailure      0                  0.0
TcpExtTCPPLBRehash              0                  0.0
IpExtInNoRoutes                 4                  0.0
IpExtInTruncatedPkts            0                  0.0
IpExtInMcastPkts                6                  0.0
IpExtOutMcastPkts               16                 0.0
IpExtInBcastPkts                0                  0.0
IpExtOutBcastPkts               0                  0.0
IpExtInOctets                   115665856793051    0.0
IpExtOutOctets                  20991618500174     0.0
IpExtInMcastOctets              306                0.0
IpExtOutMcastOctets             706                0.0
IpExtInBcastOctets              0                  0.0
IpExtOutBcastOctets             0                  0.0
IpExtInCsumErrors               0                  0.0
IpExtInNoECTPkts                41778706183        0.0
IpExtInECT1Pkts                 0                  0.0
IpExtInECT0Pkts                 299                0.0
IpExtInCEPkts                   0                  0.0
IpExtReasmOverlaps              0                  0.0

And here's the diff:

2c2
< IpInReceives                    18788097214        0.0
---
> IpInReceives                    18788830514        0.0
5c5
< IpForwDatagrams                 11778747           0.0
---
> IpForwDatagrams                 11778974           0.0
8,9c8,9
< IpInDelivers                    18776248435        0.0
< IpOutRequests                   14428799907        0.0
---
> IpInDelivers                    18776981508        0.0
> IpOutRequests                   14429439831        0.0
19,20c19,20
< IpOutTransmits                  14440537900        0.0
< IcmpInMsgs                      7052154            0.0
---
> IpOutTransmits                  14441178051        0.0
> IcmpInMsgs                      7052682            0.0
23c23
< IcmpInDestUnreachs              100237             0.0
---
> IcmpInDestUnreachs              100240             0.0
28,29c28,29
< IcmpInEchos                     4035849            0.0
< IcmpInEchoReps                  2915703            0.0
---
> IcmpInEchos                     4035969            0.0
> IcmpInEchoReps                  2916108            0.0
34c34
< IcmpOutMsgs                     7061967            0.0
---
> IcmpOutMsgs                     7062503            0.0
43,44c43,44
< IcmpOutEchos                    2969032            0.0
< IcmpOutEchoReps                 4035849            0.0
---
> IcmpOutEchos                    2969448            0.0
> IcmpOutEchoReps                 4035969            0.0
49,50c49,50
< IcmpMsgInType0                  2915703            0.0
< IcmpMsgInType3                  100237             0.0
---
> IcmpMsgInType0                  2916108            0.0
> IcmpMsgInType3                  100240             0.0
52c52
< IcmpMsgInType8                  4035849            0.0
---
> IcmpMsgInType8                  4035969            0.0
54c54
< IcmpMsgOutType0                 4035849            0.0
---
> IcmpMsgOutType0                 4035969            0.0
57c57
< IcmpMsgOutType8                 2969032            0.0
---
> IcmpMsgOutType8                 2969448            0.0
59,65c59,65
< TcpActiveOpens                  7902932            0.0
< TcpPassiveOpens                 1447146            0.0
< TcpAttemptFails                 41605              0.0
< TcpEstabResets                  1327046            0.0
< TcpInSegs                       4953075475         0.0
< TcpOutSegs                      2988066928         0.0
< TcpRetransSegs                  656187             0.0
---
> TcpActiveOpens                  7903289            0.0
> TcpPassiveOpens                 1447188            0.0
> TcpAttemptFails                 41607              0.0
> TcpEstabResets                  1327071            0.0
> TcpInSegs                       4953086019         0.0
> TcpOutSegs                      2988189227         0.0
> TcpRetransSegs                  656198             0.0
67c67
< TcpOutRsts                      3401866            0.0
---
> TcpOutRsts                      3401906            0.0
69c69
< UdpInDatagrams                  13816173054        0.0
---
> UdpInDatagrams                  13816895055        0.0
72c72
< UdpOutDatagrams                 493212273          0.0
---
> UdpOutDatagrams                 493225063          0.0
87c87
< Ip6InReceives                   268280             0.0
---
> Ip6InReceives                   268283             0.0
95c95
< Ip6InDelivers                   85862              0.0
---
> Ip6InDelivers                   85865              0.0
97c97
< Ip6OutRequests                  500197             0.0
---
> Ip6OutRequests                  500200             0.0
109,110c109,110
< Ip6InOctets                     20173005           0.0
< Ip6OutOctets                    45359068           0.0
---
> Ip6InOctets                     20173232           0.0
> Ip6OutOctets                    45359303           0.0
115c115
< Ip6InNoECTPkts                  268280             0.0
---
> Ip6InNoECTPkts                  268283             0.0
119,120c119,120
< Ip6OutTransmits                 500197             0.0
< Icmp6InMsgs                     23176              0.0
---
> Ip6OutTransmits                 500200             0.0
> Icmp6InMsgs                     23177              0.0
122c122
< Icmp6OutMsgs                    437389             0.0
---
> Icmp6OutMsgs                    437390             0.0
138c138
< Icmp6InNeighborAdvertisements   8720               0.0
---
> Icmp6InNeighborAdvertisements   8721               0.0
152c152
< Icmp6OutNeighborSolicits        69476              0.0
---
> Icmp6OutNeighborSolicits        69477              0.0
158c158
< Icmp6InType136                  8720               0.0
---
> Icmp6InType136                  8721               0.0
160c160
< Icmp6OutType135                 69476              0.0
---
> Icmp6OutType135                 69477              0.0
190c190
< TcpExtTW                        3583160            0.0
---
> TcpExtTW                        3583407            0.0
195c195
< TcpExtDelayedACKs               5133416            0.0
---
> TcpExtDelayedACKs               5133551            0.0
200,202c200,202
< TcpExtTCPHPHits                 2023413            0.0
< TcpExtTCPPureAcks               53087713           0.0
< TcpExtTCPHPAcks                 115340211          0.0
---
> TcpExtTCPHPHits                 2023452            0.0
> TcpExtTCPPureAcks               53091101           0.0
> TcpExtTCPHPAcks                 115343941          0.0
213c213
< TcpExtTCPLostRetransmit         195718             0.0
---
> TcpExtTCPLostRetransmit         195727             0.0
219,220c219,220
< TcpExtTCPTimeouts               195387             0.0
< TcpExtTCPLossProbes             110863             0.0
---
> TcpExtTCPTimeouts               195398             0.0
> TcpExtTCPLossProbes             110865             0.0
225c225
< TcpExtTCPBacklogCoalesce        252840759          0.0
---
> TcpExtTCPBacklogCoalesce        252840913          0.0
230,231c230,231
< TcpExtTCPAbortOnData            509577             0.0
< TcpExtTCPAbortOnClose           1246626            0.0
---
> TcpExtTCPAbortOnData            509579             0.0
> TcpExtTCPAbortOnClose           1246649            0.0
257c257
< TcpExtTCPRcvCoalesce            1575181380         0.0
---
> TcpExtTCPRcvCoalesce            1575181523         0.0
272c272
< TcpExtTCPAutoCorking            20400747           0.0
---
> TcpExtTCPAutoCorking            20401664           0.0
276,279c276,279
< TcpExtTCPSynRetrans             194466             0.0
< TcpExtTCPOrigDataSent           1261792021         0.0
< TcpExtTCPHystartTrainDetect     40140              0.0
< TcpExtTCPHystartTrainCwnd       4828784            0.0
---
> TcpExtTCPSynRetrans             194477             0.0
> TcpExtTCPOrigDataSent           1261911536         0.0
> TcpExtTCPHystartTrainDetect     40143              0.0
> TcpExtTCPHystartTrainCwnd       4829428            0.0
289c289
< TcpExtTCPKeepAlive              2024725            0.0
---
> TcpExtTCPKeepAlive              2024763            0.0
292c292
< TcpExtTCPDelivered              1269268682         0.0
---
> TcpExtTCPDelivered              1269388548         0.0
295c295
< TcpExtTCPZeroWindowDrop         485489             0.0
---
> TcpExtTCPZeroWindowDrop         485490             0.0
299c299
< TcpExtTcpTimeoutRehash          195346             0.0
---
> TcpExtTcpTimeoutRehash          195357             0.0
312,313c312,313
< IpExtInOctets                   115665856793051    0.0
< IpExtOutOctets                  20991618500174     0.0
---
> IpExtInOctets                   115667256768208    0.0
> IpExtOutOctets                  20993368512190     0.0
319c319
< IpExtInNoECTPkts                41778706183        0.0
---
> IpExtInNoECTPkts                41780216583        0.0



On Mon, 19 May 2025 at 16:42, Neal Cardwell <ncardwell@google.com> wrote:
>
> On Mon, May 19, 2025 at 9:31=E2=80=AFAM Simon Campion <simon.campion@deep=
l.com> wrote:
> >
> > Hi all,
> >
> > We have a TCP socket that's stuck in the following state:
> >
> > * it SACKed ~40KB of data, but misses 602 bytes at the beginning
> > * it has a zero receive window
> > * the Recv-Q as reported by ss is 0
> >
> > Due to the zero window, the kernel drops the missing 602 bytes when
> > the peer sends them. So, the socket is stuck indefinitely waiting for
> > data it drops when it receives it. Since the Recv-Q as reported by ss
> > is 0, we suspect the receive window is not 0 because the owner of the
> > socket isn't reading data. Rather, we wonder whether the kernel SACKed
> > too much data than it should have, given the receive buffer size, not
> > leaving enough space to store the missing bytes when they arrive.
> > Could this happen?
> >
> > We don't have a reproducer for this issue. The socket is still in this
> > state, so we're happy to provide more debugging information while we
> > have it. This is the first time we've seen this problem.
> >
> > Here are more details:
> >
> > # uname -r
> > 6.6.83-flatcar
>
> Thanks for the detailed report!
>
> Can you please attach the output of the following command, run on the
> same machine (and in the same network namespace) as the socket with
> the receive buffer that is almost full:
>
>   nstat -az > /tmp/nstat.txt
>
> This should help us get a better idea about which "prune" methods are
> being tried, and which of them are failing to free up enough memory.
>
> Thanks!
> neal

--000000000000a4399406357e7027
Content-Type: text/plain; charset="US-ASCII"; name="nstat_2_52.txt"
Content-Disposition: attachment; filename="nstat_2_52.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_mav7o09y0>
X-Attachment-Id: f_mav7o09y0

I2tlcm5lbApJcEluUmVjZWl2ZXMgICAgICAgICAgICAgICAgICAgIDE4Nzg4ODMwNTE0ICAgICAg
ICAwLjAKSXBJbkhkckVycm9ycyAgICAgICAgICAgICAgICAgICA0NzUyMiAgICAgICAgICAgICAg
MC4wCklwSW5BZGRyRXJyb3JzICAgICAgICAgICAgICAgICAgMCAgICAgICAgICAgICAgICAgIDAu
MApJcEZvcndEYXRhZ3JhbXMgICAgICAgICAgICAgICAgIDExNzc4OTc0ICAgICAgICAgICAwLjAK
SXBJblVua25vd25Qcm90b3MgICAgICAgICAgICAgICAwICAgICAgICAgICAgICAgICAgMC4wCklw
SW5EaXNjYXJkcyAgICAgICAgICAgICAgICAgICAgMCAgICAgICAgICAgICAgICAgIDAuMApJcElu
RGVsaXZlcnMgICAgICAgICAgICAgICAgICAgIDE4Nzc2OTgxNTA4ICAgICAgICAwLjAKSXBPdXRS
ZXF1ZXN0cyAgICAgICAgICAgICAgICAgICAxNDQyOTQzOTgzMSAgICAgICAgMC4wCklwT3V0RGlz
Y2FyZHMgICAgICAgICAgICAgICAgICAgNDA3OTggICAgICAgICAgICAgIDAuMApJcE91dE5vUm91
dGVzICAgICAgICAgICAgICAgICAgIDAgICAgICAgICAgICAgICAgICAwLjAKSXBSZWFzbVRpbWVv
dXQgICAgICAgICAgICAgICAgICAwICAgICAgICAgICAgICAgICAgMC4wCklwUmVhc21SZXFkcyAg
ICAgICAgICAgICAgICAgICAgMzI5NTIgICAgICAgICAgICAgIDAuMApJcFJlYXNtT0tzICAgICAg
ICAgICAgICAgICAgICAgIDE2NDc2ICAgICAgICAgICAgICAwLjAKSXBSZWFzbUZhaWxzICAgICAg
ICAgICAgICAgICAgICAwICAgICAgICAgICAgICAgICAgMC4wCklwRnJhZ09LcyAgICAgICAgICAg
ICAgICAgICAgICAgMCAgICAgICAgICAgICAgICAgIDAuMApJcEZyYWdGYWlscyAgICAgICAgICAg
ICAgICAgICAgIDAgICAgICAgICAgICAgICAgICAwLjAKSXBGcmFnQ3JlYXRlcyAgICAgICAgICAg
ICAgICAgICAwICAgICAgICAgICAgICAgICAgMC4wCklwT3V0VHJhbnNtaXRzICAgICAgICAgICAg
ICAgICAgMTQ0NDExNzgwNTEgICAgICAgIDAuMApJY21wSW5Nc2dzICAgICAgICAgICAgICAgICAg
ICAgIDcwNTI2ODIgICAgICAgICAgICAwLjAKSWNtcEluRXJyb3JzICAgICAgICAgICAgICAgICAg
ICAxMDcgICAgICAgICAgICAgICAgMC4wCkljbXBJbkNzdW1FcnJvcnMgICAgICAgICAgICAgICAg
MCAgICAgICAgICAgICAgICAgIDAuMApJY21wSW5EZXN0VW5yZWFjaHMgICAgICAgICAgICAgIDEw
MDI0MCAgICAgICAgICAgICAwLjAKSWNtcEluVGltZUV4Y2RzICAgICAgICAgICAgICAgICAyOTgg
ICAgICAgICAgICAgICAgMC4wCkljbXBJblBhcm1Qcm9icyAgICAgICAgICAgICAgICAgMCAgICAg
ICAgICAgICAgICAgIDAuMApJY21wSW5TcmNRdWVuY2hzICAgICAgICAgICAgICAgIDAgICAgICAg
ICAgICAgICAgICAwLjAKSWNtcEluUmVkaXJlY3RzICAgICAgICAgICAgICAgICA2NyAgICAgICAg
ICAgICAgICAgMC4wCkljbXBJbkVjaG9zICAgICAgICAgICAgICAgICAgICAgNDAzNTk2OSAgICAg
ICAgICAgIDAuMApJY21wSW5FY2hvUmVwcyAgICAgICAgICAgICAgICAgIDI5MTYxMDggICAgICAg
ICAgICAwLjAKSWNtcEluVGltZXN0YW1wcyAgICAgICAgICAgICAgICAwICAgICAgICAgICAgICAg
ICAgMC4wCkljbXBJblRpbWVzdGFtcFJlcHMgICAgICAgICAgICAgMCAgICAgICAgICAgICAgICAg
IDAuMApJY21wSW5BZGRyTWFza3MgICAgICAgICAgICAgICAgIDAgICAgICAgICAgICAgICAgICAw
LjAKSWNtcEluQWRkck1hc2tSZXBzICAgICAgICAgICAgICAwICAgICAgICAgICAgICAgICAgMC4w
CkljbXBPdXRNc2dzICAgICAgICAgICAgICAgICAgICAgNzA2MjUwMyAgICAgICAgICAgIDAuMApJ
Y21wT3V0RXJyb3JzICAgICAgICAgICAgICAgICAgIDAgICAgICAgICAgICAgICAgICAwLjAKSWNt
cE91dFJhdGVMaW1pdEdsb2JhbCAgICAgICAgICAwICAgICAgICAgICAgICAgICAgMC4wCkljbXBP
dXRSYXRlTGltaXRIb3N0ICAgICAgICAgICAgNDcwODcgICAgICAgICAgICAgIDAuMApJY21wT3V0
RGVzdFVucmVhY2hzICAgICAgICAgICAgIDEwNDIxICAgICAgICAgICAgICAwLjAKSWNtcE91dFRp
bWVFeGNkcyAgICAgICAgICAgICAgICA0NDkgICAgICAgICAgICAgICAgMC4wCkljbXBPdXRQYXJt
UHJvYnMgICAgICAgICAgICAgICAgMCAgICAgICAgICAgICAgICAgIDAuMApJY21wT3V0U3JjUXVl
bmNocyAgICAgICAgICAgICAgIDAgICAgICAgICAgICAgICAgICAwLjAKSWNtcE91dFJlZGlyZWN0
cyAgICAgICAgICAgICAgICA0NjIxNiAgICAgICAgICAgICAgMC4wCkljbXBPdXRFY2hvcyAgICAg
ICAgICAgICAgICAgICAgMjk2OTQ0OCAgICAgICAgICAgIDAuMApJY21wT3V0RWNob1JlcHMgICAg
ICAgICAgICAgICAgIDQwMzU5NjkgICAgICAgICAgICAwLjAKSWNtcE91dFRpbWVzdGFtcHMgICAg
ICAgICAgICAgICAwICAgICAgICAgICAgICAgICAgMC4wCkljbXBPdXRUaW1lc3RhbXBSZXBzICAg
ICAgICAgICAgMCAgICAgICAgICAgICAgICAgIDAuMApJY21wT3V0QWRkck1hc2tzICAgICAgICAg
ICAgICAgIDAgICAgICAgICAgICAgICAgICAwLjAKSWNtcE91dEFkZHJNYXNrUmVwcyAgICAgICAg
ICAgICAwICAgICAgICAgICAgICAgICAgMC4wCkljbXBNc2dJblR5cGUwICAgICAgICAgICAgICAg
ICAgMjkxNjEwOCAgICAgICAgICAgIDAuMApJY21wTXNnSW5UeXBlMyAgICAgICAgICAgICAgICAg
IDEwMDI0MCAgICAgICAgICAgICAwLjAKSWNtcE1zZ0luVHlwZTUgICAgICAgICAgICAgICAgICA2
NyAgICAgICAgICAgICAgICAgMC4wCkljbXBNc2dJblR5cGU4ICAgICAgICAgICAgICAgICAgNDAz
NTk2OSAgICAgICAgICAgIDAuMApJY21wTXNnSW5UeXBlMTEgICAgICAgICAgICAgICAgIDI5OCAg
ICAgICAgICAgICAgICAwLjAKSWNtcE1zZ091dFR5cGUwICAgICAgICAgICAgICAgICA0MDM1OTY5
ICAgICAgICAgICAgMC4wCkljbXBNc2dPdXRUeXBlMyAgICAgICAgICAgICAgICAgMTA0MjEgICAg
ICAgICAgICAgIDAuMApJY21wTXNnT3V0VHlwZTUgICAgICAgICAgICAgICAgIDQ2MjE2ICAgICAg
ICAgICAgICAwLjAKSWNtcE1zZ091dFR5cGU4ICAgICAgICAgICAgICAgICAyOTY5NDQ4ICAgICAg
ICAgICAgMC4wCkljbXBNc2dPdXRUeXBlMTEgICAgICAgICAgICAgICAgNDQ5ICAgICAgICAgICAg
ICAgIDAuMApUY3BBY3RpdmVPcGVucyAgICAgICAgICAgICAgICAgIDc5MDMyODkgICAgICAgICAg
ICAwLjAKVGNwUGFzc2l2ZU9wZW5zICAgICAgICAgICAgICAgICAxNDQ3MTg4ICAgICAgICAgICAg
MC4wClRjcEF0dGVtcHRGYWlscyAgICAgICAgICAgICAgICAgNDE2MDcgICAgICAgICAgICAgIDAu
MApUY3BFc3RhYlJlc2V0cyAgICAgICAgICAgICAgICAgIDEzMjcwNzEgICAgICAgICAgICAwLjAK
VGNwSW5TZWdzICAgICAgICAgICAgICAgICAgICAgICA0OTUzMDg2MDE5ICAgICAgICAgMC4wClRj
cE91dFNlZ3MgICAgICAgICAgICAgICAgICAgICAgMjk4ODE4OTIyNyAgICAgICAgIDAuMApUY3BS
ZXRyYW5zU2VncyAgICAgICAgICAgICAgICAgIDY1NjE5OCAgICAgICAgICAgICAwLjAKVGNwSW5F
cnJzICAgICAgICAgICAgICAgICAgICAgICAwICAgICAgICAgICAgICAgICAgMC4wClRjcE91dFJz
dHMgICAgICAgICAgICAgICAgICAgICAgMzQwMTkwNiAgICAgICAgICAgIDAuMApUY3BJbkNzdW1F
cnJvcnMgICAgICAgICAgICAgICAgIDAgICAgICAgICAgICAgICAgICAwLjAKVWRwSW5EYXRhZ3Jh
bXMgICAgICAgICAgICAgICAgICAxMzgxNjg5NTA1NSAgICAgICAgMC4wClVkcE5vUG9ydHMgICAg
ICAgICAgICAgICAgICAgICAgMTA0MzUgICAgICAgICAgICAgIDAuMApVZHBJbkVycm9ycyAgICAg
ICAgICAgICAgICAgICAgIDIgICAgICAgICAgICAgICAgICAwLjAKVWRwT3V0RGF0YWdyYW1zICAg
ICAgICAgICAgICAgICA0OTMyMjUwNjMgICAgICAgICAgMC4wClVkcFJjdmJ1ZkVycm9ycyAgICAg
ICAgICAgICAgICAgMCAgICAgICAgICAgICAgICAgIDAuMApVZHBTbmRidWZFcnJvcnMgICAgICAg
ICAgICAgICAgIDEwICAgICAgICAgICAgICAgICAwLjAKVWRwSW5Dc3VtRXJyb3JzICAgICAgICAg
ICAgICAgICAwICAgICAgICAgICAgICAgICAgMC4wClVkcElnbm9yZWRNdWx0aSAgICAgICAgICAg
ICAgICAgMCAgICAgICAgICAgICAgICAgIDAuMApVZHBNZW1FcnJvcnMgICAgICAgICAgICAgICAg
ICAgIDAgICAgICAgICAgICAgICAgICAwLjAKVWRwTGl0ZUluRGF0YWdyYW1zICAgICAgICAgICAg
ICAwICAgICAgICAgICAgICAgICAgMC4wClVkcExpdGVOb1BvcnRzICAgICAgICAgICAgICAgICAg
MCAgICAgICAgICAgICAgICAgIDAuMApVZHBMaXRlSW5FcnJvcnMgICAgICAgICAgICAgICAgIDAg
ICAgICAgICAgICAgICAgICAwLjAKVWRwTGl0ZU91dERhdGFncmFtcyAgICAgICAgICAgICAwICAg
ICAgICAgICAgICAgICAgMC4wClVkcExpdGVSY3ZidWZFcnJvcnMgICAgICAgICAgICAgMCAgICAg
ICAgICAgICAgICAgIDAuMApVZHBMaXRlU25kYnVmRXJyb3JzICAgICAgICAgICAgIDAgICAgICAg
ICAgICAgICAgICAwLjAKVWRwTGl0ZUluQ3N1bUVycm9ycyAgICAgICAgICAgICAwICAgICAgICAg
ICAgICAgICAgMC4wClVkcExpdGVJZ25vcmVkTXVsdGkgICAgICAgICAgICAgMCAgICAgICAgICAg
ICAgICAgIDAuMApVZHBMaXRlTWVtRXJyb3JzICAgICAgICAgICAgICAgIDAgICAgICAgICAgICAg
ICAgICAwLjAKSXA2SW5SZWNlaXZlcyAgICAgICAgICAgICAgICAgICAyNjgyODMgICAgICAgICAg
ICAgMC4wCklwNkluSGRyRXJyb3JzICAgICAgICAgICAgICAgICAgMCAgICAgICAgICAgICAgICAg
IDAuMApJcDZJblRvb0JpZ0Vycm9ycyAgICAgICAgICAgICAgIDAgICAgICAgICAgICAgICAgICAw
LjAKSXA2SW5Ob1JvdXRlcyAgICAgICAgICAgICAgICAgICAzOSAgICAgICAgICAgICAgICAgMC4w
CklwNkluQWRkckVycm9ycyAgICAgICAgICAgICAgICAgMCAgICAgICAgICAgICAgICAgIDAuMApJ
cDZJblVua25vd25Qcm90b3MgICAgICAgICAgICAgIDAgICAgICAgICAgICAgICAgICAwLjAKSXA2
SW5UcnVuY2F0ZWRQa3RzICAgICAgICAgICAgICAwICAgICAgICAgICAgICAgICAgMC4wCklwNklu
RGlzY2FyZHMgICAgICAgICAgICAgICAgICAgMCAgICAgICAgICAgICAgICAgIDAuMApJcDZJbkRl
bGl2ZXJzICAgICAgICAgICAgICAgICAgIDg1ODY1ICAgICAgICAgICAgICAwLjAKSXA2T3V0Rm9y
d0RhdGFncmFtcyAgICAgICAgICAgICAwICAgICAgICAgICAgICAgICAgMC4wCklwNk91dFJlcXVl
c3RzICAgICAgICAgICAgICAgICAgNTAwMjAwICAgICAgICAgICAgIDAuMApJcDZPdXREaXNjYXJk
cyAgICAgICAgICAgICAgICAgIDEgICAgICAgICAgICAgICAgICAwLjAKSXA2T3V0Tm9Sb3V0ZXMg
ICAgICAgICAgICAgICAgICA1OTEgICAgICAgICAgICAgICAgMC4wCklwNlJlYXNtVGltZW91dCAg
ICAgICAgICAgICAgICAgMCAgICAgICAgICAgICAgICAgIDAuMApJcDZSZWFzbVJlcWRzICAgICAg
ICAgICAgICAgICAgIDAgICAgICAgICAgICAgICAgICAwLjAKSXA2UmVhc21PS3MgICAgICAgICAg
ICAgICAgICAgICAwICAgICAgICAgICAgICAgICAgMC4wCklwNlJlYXNtRmFpbHMgICAgICAgICAg
ICAgICAgICAgMCAgICAgICAgICAgICAgICAgIDAuMApJcDZGcmFnT0tzICAgICAgICAgICAgICAg
ICAgICAgIDAgICAgICAgICAgICAgICAgICAwLjAKSXA2RnJhZ0ZhaWxzICAgICAgICAgICAgICAg
ICAgICAwICAgICAgICAgICAgICAgICAgMC4wCklwNkZyYWdDcmVhdGVzICAgICAgICAgICAgICAg
ICAgMCAgICAgICAgICAgICAgICAgIDAuMApJcDZJbk1jYXN0UGt0cyAgICAgICAgICAgICAgICAg
IDE5NDcyNyAgICAgICAgICAgICAwLjAKSXA2T3V0TWNhc3RQa3RzICAgICAgICAgICAgICAgICA0
MjY1NjIgICAgICAgICAgICAgMC4wCklwNkluT2N0ZXRzICAgICAgICAgICAgICAgICAgICAgMjAx
NzMyMzIgICAgICAgICAgIDAuMApJcDZPdXRPY3RldHMgICAgICAgICAgICAgICAgICAgIDQ1MzU5
MzAzICAgICAgICAgICAwLjAKSXA2SW5NY2FzdE9jdGV0cyAgICAgICAgICAgICAgICAxNDM0NTQ5
NCAgICAgICAgICAgMC4wCklwNk91dE1jYXN0T2N0ZXRzICAgICAgICAgICAgICAgMzk0NDA3OTAg
ICAgICAgICAgIDAuMApJcDZJbkJjYXN0T2N0ZXRzICAgICAgICAgICAgICAgIDAgICAgICAgICAg
ICAgICAgICAwLjAKSXA2T3V0QmNhc3RPY3RldHMgICAgICAgICAgICAgICAwICAgICAgICAgICAg
ICAgICAgMC4wCklwNkluTm9FQ1RQa3RzICAgICAgICAgICAgICAgICAgMjY4MjgzICAgICAgICAg
ICAgIDAuMApJcDZJbkVDVDFQa3RzICAgICAgICAgICAgICAgICAgIDAgICAgICAgICAgICAgICAg
ICAwLjAKSXA2SW5FQ1QwUGt0cyAgICAgICAgICAgICAgICAgICAwICAgICAgICAgICAgICAgICAg
MC4wCklwNkluQ0VQa3RzICAgICAgICAgICAgICAgICAgICAgMCAgICAgICAgICAgICAgICAgIDAu
MApJcDZPdXRUcmFuc21pdHMgICAgICAgICAgICAgICAgIDUwMDIwMCAgICAgICAgICAgICAwLjAK
SWNtcDZJbk1zZ3MgICAgICAgICAgICAgICAgICAgICAyMzE3NyAgICAgICAgICAgICAgMC4wCklj
bXA2SW5FcnJvcnMgICAgICAgICAgICAgICAgICAgMCAgICAgICAgICAgICAgICAgIDAuMApJY21w
Nk91dE1zZ3MgICAgICAgICAgICAgICAgICAgIDQzNzM5MCAgICAgICAgICAgICAwLjAKSWNtcDZP
dXRFcnJvcnMgICAgICAgICAgICAgICAgICAwICAgICAgICAgICAgICAgICAgMC4wCkljbXA2SW5D
c3VtRXJyb3JzICAgICAgICAgICAgICAgMCAgICAgICAgICAgICAgICAgIDAuMApJY21wNk91dFJh
dGVMaW1pdEhvc3QgICAgICAgICAgIDAgICAgICAgICAgICAgICAgICAwLjAKSWNtcDZJbkRlc3RV
bnJlYWNocyAgICAgICAgICAgICAwICAgICAgICAgICAgICAgICAgMC4wCkljbXA2SW5Qa3RUb29C
aWdzICAgICAgICAgICAgICAgMCAgICAgICAgICAgICAgICAgIDAuMApJY21wNkluVGltZUV4Y2Rz
ICAgICAgICAgICAgICAgIDAgICAgICAgICAgICAgICAgICAwLjAKSWNtcDZJblBhcm1Qcm9ibGVt
cyAgICAgICAgICAgICAwICAgICAgICAgICAgICAgICAgMC4wCkljbXA2SW5FY2hvcyAgICAgICAg
ICAgICAgICAgICAgMCAgICAgICAgICAgICAgICAgIDAuMApJY21wNkluRWNob1JlcGxpZXMgICAg
ICAgICAgICAgIDAgICAgICAgICAgICAgICAgICAwLjAKSWNtcDZJbkdyb3VwTWVtYlF1ZXJpZXMg
ICAgICAgICAwICAgICAgICAgICAgICAgICAgMC4wCkljbXA2SW5Hcm91cE1lbWJSZXNwb25zZXMg
ICAgICAgMCAgICAgICAgICAgICAgICAgIDAuMApJY21wNkluR3JvdXBNZW1iUmVkdWN0aW9ucyAg
ICAgIDAgICAgICAgICAgICAgICAgICAwLjAKSWNtcDZJblJvdXRlclNvbGljaXRzICAgICAgICAg
ICAxMjMzOSAgICAgICAgICAgICAgMC4wCkljbXA2SW5Sb3V0ZXJBZHZlcnRpc2VtZW50cyAgICAg
MCAgICAgICAgICAgICAgICAgIDAuMApJY21wNkluTmVpZ2hib3JTb2xpY2l0cyAgICAgICAgIDIx
MTcgICAgICAgICAgICAgICAwLjAKSWNtcDZJbk5laWdoYm9yQWR2ZXJ0aXNlbWVudHMgICA4NzIx
ICAgICAgICAgICAgICAgMC4wCkljbXA2SW5SZWRpcmVjdHMgICAgICAgICAgICAgICAgMCAgICAg
ICAgICAgICAgICAgIDAuMApJY21wNkluTUxEdjJSZXBvcnRzICAgICAgICAgICAgIDAgICAgICAg
ICAgICAgICAgICAwLjAKSWNtcDZPdXREZXN0VW5yZWFjaHMgICAgICAgICAgICAwICAgICAgICAg
ICAgICAgICAgMC4wCkljbXA2T3V0UGt0VG9vQmlncyAgICAgICAgICAgICAgMCAgICAgICAgICAg
ICAgICAgIDAuMApJY21wNk91dFRpbWVFeGNkcyAgICAgICAgICAgICAgIDAgICAgICAgICAgICAg
ICAgICAwLjAKSWNtcDZPdXRQYXJtUHJvYmxlbXMgICAgICAgICAgICAwICAgICAgICAgICAgICAg
ICAgMC4wCkljbXA2T3V0RWNob3MgICAgICAgICAgICAgICAgICAgMCAgICAgICAgICAgICAgICAg
IDAuMApJY21wNk91dEVjaG9SZXBsaWVzICAgICAgICAgICAgIDAgICAgICAgICAgICAgICAgICAw
LjAKSWNtcDZPdXRHcm91cE1lbWJRdWVyaWVzICAgICAgICAwICAgICAgICAgICAgICAgICAgMC4w
CkljbXA2T3V0R3JvdXBNZW1iUmVzcG9uc2VzICAgICAgMCAgICAgICAgICAgICAgICAgIDAuMApJ
Y21wNk91dEdyb3VwTWVtYlJlZHVjdGlvbnMgICAgIDAgICAgICAgICAgICAgICAgICAwLjAKSWNt
cDZPdXRSb3V0ZXJTb2xpY2l0cyAgICAgICAgICAyICAgICAgICAgICAgICAgICAgMC4wCkljbXA2
T3V0Um91dGVyQWR2ZXJ0aXNlbWVudHMgICAgMCAgICAgICAgICAgICAgICAgIDAuMApJY21wNk91
dE5laWdoYm9yU29saWNpdHMgICAgICAgIDY5NDc3ICAgICAgICAgICAgICAwLjAKSWNtcDZPdXRO
ZWlnaGJvckFkdmVydGlzZW1lbnRzICAyMTE2ICAgICAgICAgICAgICAgMC4wCkljbXA2T3V0UmVk
aXJlY3RzICAgICAgICAgICAgICAgMCAgICAgICAgICAgICAgICAgIDAuMApJY21wNk91dE1MRHYy
UmVwb3J0cyAgICAgICAgICAgIDM2NTc5NSAgICAgICAgICAgICAwLjAKSWNtcDZJblR5cGUxMzMg
ICAgICAgICAgICAgICAgICAxMjMzOSAgICAgICAgICAgICAgMC4wCkljbXA2SW5UeXBlMTM1ICAg
ICAgICAgICAgICAgICAgMjExNyAgICAgICAgICAgICAgIDAuMApJY21wNkluVHlwZTEzNiAgICAg
ICAgICAgICAgICAgIDg3MjEgICAgICAgICAgICAgICAwLjAKSWNtcDZPdXRUeXBlMTMzICAgICAg
ICAgICAgICAgICAyICAgICAgICAgICAgICAgICAgMC4wCkljbXA2T3V0VHlwZTEzNSAgICAgICAg
ICAgICAgICAgNjk0NzcgICAgICAgICAgICAgIDAuMApJY21wNk91dFR5cGUxMzYgICAgICAgICAg
ICAgICAgIDIxMTYgICAgICAgICAgICAgICAwLjAKSWNtcDZPdXRUeXBlMTQzICAgICAgICAgICAg
ICAgICAzNjU3OTUgICAgICAgICAgICAgMC4wClVkcDZJbkRhdGFncmFtcyAgICAgICAgICAgICAg
ICAgNiAgICAgICAgICAgICAgICAgIDAuMApVZHA2Tm9Qb3J0cyAgICAgICAgICAgICAgICAgICAg
IDAgICAgICAgICAgICAgICAgICAwLjAKVWRwNkluRXJyb3JzICAgICAgICAgICAgICAgICAgICAw
ICAgICAgICAgICAgICAgICAgMC4wClVkcDZPdXREYXRhZ3JhbXMgICAgICAgICAgICAgICAgNiAg
ICAgICAgICAgICAgICAgIDAuMApVZHA2UmN2YnVmRXJyb3JzICAgICAgICAgICAgICAgIDAgICAg
ICAgICAgICAgICAgICAwLjAKVWRwNlNuZGJ1ZkVycm9ycyAgICAgICAgICAgICAgICAwICAgICAg
ICAgICAgICAgICAgMC4wClVkcDZJbkNzdW1FcnJvcnMgICAgICAgICAgICAgICAgMCAgICAgICAg
ICAgICAgICAgIDAuMApVZHA2SWdub3JlZE11bHRpICAgICAgICAgICAgICAgIDAgICAgICAgICAg
ICAgICAgICAwLjAKVWRwNk1lbUVycm9ycyAgICAgICAgICAgICAgICAgICAwICAgICAgICAgICAg
ICAgICAgMC4wClVkcExpdGU2SW5EYXRhZ3JhbXMgICAgICAgICAgICAgMCAgICAgICAgICAgICAg
ICAgIDAuMApVZHBMaXRlNk5vUG9ydHMgICAgICAgICAgICAgICAgIDAgICAgICAgICAgICAgICAg
ICAwLjAKVWRwTGl0ZTZJbkVycm9ycyAgICAgICAgICAgICAgICAwICAgICAgICAgICAgICAgICAg
MC4wClVkcExpdGU2T3V0RGF0YWdyYW1zICAgICAgICAgICAgMCAgICAgICAgICAgICAgICAgIDAu
MApVZHBMaXRlNlJjdmJ1ZkVycm9ycyAgICAgICAgICAgIDAgICAgICAgICAgICAgICAgICAwLjAK
VWRwTGl0ZTZTbmRidWZFcnJvcnMgICAgICAgICAgICAwICAgICAgICAgICAgICAgICAgMC4wClVk
cExpdGU2SW5Dc3VtRXJyb3JzICAgICAgICAgICAgMCAgICAgICAgICAgICAgICAgIDAuMApVZHBM
aXRlNk1lbUVycm9ycyAgICAgICAgICAgICAgIDAgICAgICAgICAgICAgICAgICAwLjAKVGNwRXh0
U3luY29va2llc1NlbnQgICAgICAgICAgICAwICAgICAgICAgICAgICAgICAgMC4wClRjcEV4dFN5
bmNvb2tpZXNSZWN2ICAgICAgICAgICAgMCAgICAgICAgICAgICAgICAgIDAuMApUY3BFeHRTeW5j
b29raWVzRmFpbGVkICAgICAgICAgIDAgICAgICAgICAgICAgICAgICAwLjAKVGNwRXh0RW1icnlv
bmljUnN0cyAgICAgICAgICAgICAzICAgICAgICAgICAgICAgICAgMC4wClRjcEV4dFBydW5lQ2Fs
bGVkICAgICAgICAgICAgICAgMzg5MSAgICAgICAgICAgICAgIDAuMApUY3BFeHRSY3ZQcnVuZWQg
ICAgICAgICAgICAgICAgIDAgICAgICAgICAgICAgICAgICAwLjAKVGNwRXh0T2ZvUHJ1bmVkICAg
ICAgICAgICAgICAgICAwICAgICAgICAgICAgICAgICAgMC4wClRjcEV4dE91dE9mV2luZG93SWNt
cHMgICAgICAgICAgMTAgICAgICAgICAgICAgICAgIDAuMApUY3BFeHRMb2NrRHJvcHBlZEljbXBz
ICAgICAgICAgIDE3OCAgICAgICAgICAgICAgICAwLjAKVGNwRXh0QXJwRmlsdGVyICAgICAgICAg
ICAgICAgICAwICAgICAgICAgICAgICAgICAgMC4wClRjcEV4dFRXICAgICAgICAgICAgICAgICAg
ICAgICAgMzU4MzQwNyAgICAgICAgICAgIDAuMApUY3BFeHRUV1JlY3ljbGVkICAgICAgICAgICAg
ICAgIDQyMTcgICAgICAgICAgICAgICAwLjAKVGNwRXh0VFdLaWxsZWQgICAgICAgICAgICAgICAg
ICAwICAgICAgICAgICAgICAgICAgMC4wClRjcEV4dFBBV1NBY3RpdmUgICAgICAgICAgICAgICAg
MCAgICAgICAgICAgICAgICAgIDAuMApUY3BFeHRQQVdTRXN0YWIgICAgICAgICAgICAgICAgIDYw
ICAgICAgICAgICAgICAgICAwLjAKVGNwRXh0RGVsYXllZEFDS3MgICAgICAgICAgICAgICA1MTMz
NTUxICAgICAgICAgICAgMC4wClRjcEV4dERlbGF5ZWRBQ0tMb2NrZWQgICAgICAgICAgMzAwOCAg
ICAgICAgICAgICAgIDAuMApUY3BFeHREZWxheWVkQUNLTG9zdCAgICAgICAgICAgIDExMTE2NSAg
ICAgICAgICAgICAwLjAKVGNwRXh0TGlzdGVuT3ZlcmZsb3dzICAgICAgICAgICAwICAgICAgICAg
ICAgICAgICAgMC4wClRjcEV4dExpc3RlbkRyb3BzICAgICAgICAgICAgICAgMCAgICAgICAgICAg
ICAgICAgIDAuMApUY3BFeHRUQ1BIUEhpdHMgICAgICAgICAgICAgICAgIDIwMjM0NTIgICAgICAg
ICAgICAwLjAKVGNwRXh0VENQUHVyZUFja3MgICAgICAgICAgICAgICA1MzA5MTEwMSAgICAgICAg
ICAgMC4wClRjcEV4dFRDUEhQQWNrcyAgICAgICAgICAgICAgICAgMTE1MzQzOTQxICAgICAgICAg
IDAuMApUY3BFeHRUQ1BSZW5vUmVjb3ZlcnkgICAgICAgICAgIDAgICAgICAgICAgICAgICAgICAw
LjAKVGNwRXh0VENQU2Fja1JlY292ZXJ5ICAgICAgICAgICAxMzM5NiAgICAgICAgICAgICAgMC4w
ClRjcEV4dFRDUFNBQ0tSZW5lZ2luZyAgICAgICAgICAgMCAgICAgICAgICAgICAgICAgIDAuMApU
Y3BFeHRUQ1BTQUNLUmVvcmRlciAgICAgICAgICAgIDIwMiAgICAgICAgICAgICAgICAwLjAKVGNw
RXh0VENQUmVub1Jlb3JkZXIgICAgICAgICAgICAwICAgICAgICAgICAgICAgICAgMC4wClRjcEV4
dFRDUFRTUmVvcmRlciAgICAgICAgICAgICAgMSAgICAgICAgICAgICAgICAgIDAuMApUY3BFeHRU
Q1BGdWxsVW5kbyAgICAgICAgICAgICAgIDAgICAgICAgICAgICAgICAgICAwLjAKVGNwRXh0VENQ
UGFydGlhbFVuZG8gICAgICAgICAgICAxICAgICAgICAgICAgICAgICAgMC4wClRjcEV4dFRDUERT
QUNLVW5kbyAgICAgICAgICAgICAgMjUyICAgICAgICAgICAgICAgIDAuMApUY3BFeHRUQ1BMb3Nz
VW5kbyAgICAgICAgICAgICAgIDg1ICAgICAgICAgICAgICAgICAwLjAKVGNwRXh0VENQTG9zdFJl
dHJhbnNtaXQgICAgICAgICAxOTU3MjcgICAgICAgICAgICAgMC4wClRjcEV4dFRDUFJlbm9GYWls
dXJlcyAgICAgICAgICAgMCAgICAgICAgICAgICAgICAgIDAuMApUY3BFeHRUQ1BTYWNrRmFpbHVy
ZXMgICAgICAgICAgIDMgICAgICAgICAgICAgICAgICAwLjAKVGNwRXh0VENQTG9zc0ZhaWx1cmVz
ICAgICAgICAgICAwICAgICAgICAgICAgICAgICAgMC4wClRjcEV4dFRDUEZhc3RSZXRyYW5zICAg
ICAgICAgICAgMzgxOTc2ICAgICAgICAgICAgIDAuMApUY3BFeHRUQ1BTbG93U3RhcnRSZXRyYW5z
ICAgICAgIDc2ICAgICAgICAgICAgICAgICAwLjAKVGNwRXh0VENQVGltZW91dHMgICAgICAgICAg
ICAgICAxOTUzOTggICAgICAgICAgICAgMC4wClRjcEV4dFRDUExvc3NQcm9iZXMgICAgICAgICAg
ICAgMTEwODY1ICAgICAgICAgICAgIDAuMApUY3BFeHRUQ1BMb3NzUHJvYmVSZWNvdmVyeSAgICAg
IDc3MyAgICAgICAgICAgICAgICAwLjAKVGNwRXh0VENQUmVub1JlY292ZXJ5RmFpbCAgICAgICAw
ICAgICAgICAgICAgICAgICAgMC4wClRjcEV4dFRDUFNhY2tSZWNvdmVyeUZhaWwgICAgICAgMzgg
ICAgICAgICAgICAgICAgIDAuMApUY3BFeHRUQ1BSY3ZDb2xsYXBzZWQgICAgICAgICAgIDI5NjAg
ICAgICAgICAgICAgICAwLjAKVGNwRXh0VENQQmFja2xvZ0NvYWxlc2NlICAgICAgICAyNTI4NDA5
MTMgICAgICAgICAgMC4wClRjcEV4dFRDUERTQUNLT2xkU2VudCAgICAgICAgICAgMTExMjE2ICAg
ICAgICAgICAgIDAuMApUY3BFeHRUQ1BEU0FDS09mb1NlbnQgICAgICAgICAgIDIgICAgICAgICAg
ICAgICAgICAwLjAKVGNwRXh0VENQRFNBQ0tSZWN2ICAgICAgICAgICAgICA3NzUyMyAgICAgICAg
ICAgICAgMC4wClRjcEV4dFRDUERTQUNLT2ZvUmVjdiAgICAgICAgICAgMyAgICAgICAgICAgICAg
ICAgIDAuMApUY3BFeHRUQ1BBYm9ydE9uRGF0YSAgICAgICAgICAgIDUwOTU3OSAgICAgICAgICAg
ICAwLjAKVGNwRXh0VENQQWJvcnRPbkNsb3NlICAgICAgICAgICAxMjQ2NjQ5ICAgICAgICAgICAg
MC4wClRjcEV4dFRDUEFib3J0T25NZW1vcnkgICAgICAgICAgMCAgICAgICAgICAgICAgICAgIDAu
MApUY3BFeHRUQ1BBYm9ydE9uVGltZW91dCAgICAgICAgIDMyICAgICAgICAgICAgICAgICAwLjAK
VGNwRXh0VENQQWJvcnRPbkxpbmdlciAgICAgICAgICAwICAgICAgICAgICAgICAgICAgMC4wClRj
cEV4dFRDUEFib3J0RmFpbGVkICAgICAgICAgICAgMCAgICAgICAgICAgICAgICAgIDAuMApUY3BF
eHRUQ1BNZW1vcnlQcmVzc3VyZXMgICAgICAgIDAgICAgICAgICAgICAgICAgICAwLjAKVGNwRXh0
VENQTWVtb3J5UHJlc3N1cmVzQ2hyb25vICAwICAgICAgICAgICAgICAgICAgMC4wClRjcEV4dFRD
UFNBQ0tEaXNjYXJkICAgICAgICAgICAgMTAgICAgICAgICAgICAgICAgIDAuMApUY3BFeHRUQ1BE
U0FDS0lnbm9yZWRPbGQgICAgICAgIDIgICAgICAgICAgICAgICAgICAwLjAKVGNwRXh0VENQRFNB
Q0tJZ25vcmVkTm9VbmRvICAgICA3MzMxMCAgICAgICAgICAgICAgMC4wClRjcEV4dFRDUFNwdXJp
b3VzUlRPcyAgICAgICAgICAgMjMgICAgICAgICAgICAgICAgIDAuMApUY3BFeHRUQ1BNRDVOb3RG
b3VuZCAgICAgICAgICAgIDAgICAgICAgICAgICAgICAgICAwLjAKVGNwRXh0VENQTUQ1VW5leHBl
Y3RlZCAgICAgICAgICAwICAgICAgICAgICAgICAgICAgMC4wClRjcEV4dFRDUE1ENUZhaWx1cmUg
ICAgICAgICAgICAgMCAgICAgICAgICAgICAgICAgIDAuMApUY3BFeHRUQ1BTYWNrU2hpZnRlZCAg
ICAgICAgICAgIDQ1OTc1ICAgICAgICAgICAgICAwLjAKVGNwRXh0VENQU2Fja01lcmdlZCAgICAg
ICAgICAgICAyNDgyMDcgICAgICAgICAgICAgMC4wClRjcEV4dFRDUFNhY2tTaGlmdEZhbGxiYWNr
ICAgICAgMzI4MjU3ICAgICAgICAgICAgIDAuMApUY3BFeHRUQ1BCYWNrbG9nRHJvcCAgICAgICAg
ICAgIDAgICAgICAgICAgICAgICAgICAwLjAKVGNwRXh0UEZNZW1hbGxvY0Ryb3AgICAgICAgICAg
ICAwICAgICAgICAgICAgICAgICAgMC4wClRjcEV4dFRDUE1pblRUTERyb3AgICAgICAgICAgICAg
MCAgICAgICAgICAgICAgICAgIDAuMApUY3BFeHRUQ1BEZWZlckFjY2VwdERyb3AgICAgICAgIDAg
ICAgICAgICAgICAgICAgICAwLjAKVGNwRXh0SVBSZXZlcnNlUGF0aEZpbHRlciAgICAgICAwICAg
ICAgICAgICAgICAgICAgMC4wClRjcEV4dFRDUFRpbWVXYWl0T3ZlcmZsb3cgICAgICAgMCAgICAg
ICAgICAgICAgICAgIDAuMApUY3BFeHRUQ1BSZXFRRnVsbERvQ29va2llcyAgICAgIDAgICAgICAg
ICAgICAgICAgICAwLjAKVGNwRXh0VENQUmVxUUZ1bGxEcm9wICAgICAgICAgICAwICAgICAgICAg
ICAgICAgICAgMC4wClRjcEV4dFRDUFJldHJhbnNGYWlsICAgICAgICAgICAgNTUgICAgICAgICAg
ICAgICAgIDAuMApUY3BFeHRUQ1BSY3ZDb2FsZXNjZSAgICAgICAgICAgIDE1NzUxODE1MjMgICAg
ICAgICAwLjAKVGNwRXh0VENQT0ZPUXVldWUgICAgICAgICAgICAgICAyNjYxMzYzICAgICAgICAg
ICAgMC4wClRjcEV4dFRDUE9GT0Ryb3AgICAgICAgICAgICAgICAgMCAgICAgICAgICAgICAgICAg
IDAuMApUY3BFeHRUQ1BPRk9NZXJnZSAgICAgICAgICAgICAgIDIgICAgICAgICAgICAgICAgICAw
LjAKVGNwRXh0VENQQ2hhbGxlbmdlQUNLICAgICAgICAgICAxMzggICAgICAgICAgICAgICAgMC4w
ClRjcEV4dFRDUFNZTkNoYWxsZW5nZSAgICAgICAgICAgODcgICAgICAgICAgICAgICAgIDAuMApU
Y3BFeHRUQ1BGYXN0T3BlbkFjdGl2ZSAgICAgICAgIDAgICAgICAgICAgICAgICAgICAwLjAKVGNw
RXh0VENQRmFzdE9wZW5BY3RpdmVGYWlsICAgICAwICAgICAgICAgICAgICAgICAgMC4wClRjcEV4
dFRDUEZhc3RPcGVuUGFzc2l2ZSAgICAgICAgMCAgICAgICAgICAgICAgICAgIDAuMApUY3BFeHRU
Q1BGYXN0T3BlblBhc3NpdmVGYWlsICAgIDAgICAgICAgICAgICAgICAgICAwLjAKVGNwRXh0VENQ
RmFzdE9wZW5MaXN0ZW5PdmVyZmxvdyAwICAgICAgICAgICAgICAgICAgMC4wClRjcEV4dFRDUEZh
c3RPcGVuQ29va2llUmVxZCAgICAgMCAgICAgICAgICAgICAgICAgIDAuMApUY3BFeHRUQ1BGYXN0
T3BlbkJsYWNraG9sZSAgICAgIDAgICAgICAgICAgICAgICAgICAwLjAKVGNwRXh0VENQU3B1cmlv
dXNSdHhIb3N0UXVldWVzICAxMTggICAgICAgICAgICAgICAgMC4wClRjcEV4dEJ1c3lQb2xsUnhQ
YWNrZXRzICAgICAgICAgMCAgICAgICAgICAgICAgICAgIDAuMApUY3BFeHRUQ1BBdXRvQ29ya2lu
ZyAgICAgICAgICAgIDIwNDAxNjY0ICAgICAgICAgICAwLjAKVGNwRXh0VENQRnJvbVplcm9XaW5k
b3dBZHYgICAgICAzNjEyOTQ5ICAgICAgICAgICAgMC4wClRjcEV4dFRDUFRvWmVyb1dpbmRvd0Fk
diAgICAgICAgMzYxMjk1MyAgICAgICAgICAgIDAuMApUY3BFeHRUQ1BXYW50WmVyb1dpbmRvd0Fk
diAgICAgIDAgICAgICAgICAgICAgICAgICAwLjAKVGNwRXh0VENQU3luUmV0cmFucyAgICAgICAg
ICAgICAxOTQ0NzcgICAgICAgICAgICAgMC4wClRjcEV4dFRDUE9yaWdEYXRhU2VudCAgICAgICAg
ICAgMTI2MTkxMTUzNiAgICAgICAgIDAuMApUY3BFeHRUQ1BIeXN0YXJ0VHJhaW5EZXRlY3QgICAg
IDQwMTQzICAgICAgICAgICAgICAwLjAKVGNwRXh0VENQSHlzdGFydFRyYWluQ3duZCAgICAgICA0
ODI5NDI4ICAgICAgICAgICAgMC4wClRjcEV4dFRDUEh5c3RhcnREZWxheURldGVjdCAgICAgMTcg
ICAgICAgICAgICAgICAgIDAuMApUY3BFeHRUQ1BIeXN0YXJ0RGVsYXlDd25kICAgICAgIDg0ODkg
ICAgICAgICAgICAgICAwLjAKVGNwRXh0VENQQUNLU2tpcHBlZFN5blJlY3YgICAgICAwICAgICAg
ICAgICAgICAgICAgMC4wClRjcEV4dFRDUEFDS1NraXBwZWRQQVdTICAgICAgICAgMyAgICAgICAg
ICAgICAgICAgIDAuMApUY3BFeHRUQ1BBQ0tTa2lwcGVkU2VxICAgICAgICAgIDU4MCAgICAgICAg
ICAgICAgICAwLjAKVGNwRXh0VENQQUNLU2tpcHBlZEZpbldhaXQyICAgICAwICAgICAgICAgICAg
ICAgICAgMC4wClRjcEV4dFRDUEFDS1NraXBwZWRUaW1lV2FpdCAgICAgMCAgICAgICAgICAgICAg
ICAgIDAuMApUY3BFeHRUQ1BBQ0tTa2lwcGVkQ2hhbGxlbmdlICAgIDAgICAgICAgICAgICAgICAg
ICAwLjAKVGNwRXh0VENQV2luUHJvYmUgICAgICAgICAgICAgICAwICAgICAgICAgICAgICAgICAg
MC4wClRjcEV4dFRDUEtlZXBBbGl2ZSAgICAgICAgICAgICAgMjAyNDc2MyAgICAgICAgICAgIDAu
MApUY3BFeHRUQ1BNVFVQRmFpbCAgICAgICAgICAgICAgIDAgICAgICAgICAgICAgICAgICAwLjAK
VGNwRXh0VENQTVRVUFN1Y2Nlc3MgICAgICAgICAgICAwICAgICAgICAgICAgICAgICAgMC4wClRj
cEV4dFRDUERlbGl2ZXJlZCAgICAgICAgICAgICAgMTI2OTM4ODU0OCAgICAgICAgIDAuMApUY3BF
eHRUQ1BEZWxpdmVyZWRDRSAgICAgICAgICAgIDAgICAgICAgICAgICAgICAgICAwLjAKVGNwRXh0
VENQQWNrQ29tcHJlc3NlZCAgICAgICAgICAxMDI4MzA2ICAgICAgICAgICAgMC4wClRjcEV4dFRD
UFplcm9XaW5kb3dEcm9wICAgICAgICAgNDg1NDkwICAgICAgICAgICAgIDAuMApUY3BFeHRUQ1BS
Y3ZRRHJvcCAgICAgICAgICAgICAgIDAgICAgICAgICAgICAgICAgICAwLjAKVGNwRXh0VENQV3F1
ZXVlVG9vQmlnICAgICAgICAgICAwICAgICAgICAgICAgICAgICAgMC4wClRjcEV4dFRDUEZhc3RP
cGVuUGFzc2l2ZUFsdEtleSAgMCAgICAgICAgICAgICAgICAgIDAuMApUY3BFeHRUY3BUaW1lb3V0
UmVoYXNoICAgICAgICAgIDE5NTM1NyAgICAgICAgICAgICAwLjAKVGNwRXh0VGNwRHVwbGljYXRl
RGF0YVJlaGFzaCAgICA1MyAgICAgICAgICAgICAgICAgMC4wClRjcEV4dFRDUERTQUNLUmVjdlNl
Z3MgICAgICAgICAgNzc1MzkgICAgICAgICAgICAgIDAuMApUY3BFeHRUQ1BEU0FDS0lnbm9yZWRE
dWJpb3VzICAgIDEyICAgICAgICAgICAgICAgICAwLjAKVGNwRXh0VENQTWlncmF0ZVJlcVN1Y2Nl
c3MgICAgICAwICAgICAgICAgICAgICAgICAgMC4wClRjcEV4dFRDUE1pZ3JhdGVSZXFGYWlsdXJl
ICAgICAgMCAgICAgICAgICAgICAgICAgIDAuMApUY3BFeHRUQ1BQTEJSZWhhc2ggICAgICAgICAg
ICAgIDAgICAgICAgICAgICAgICAgICAwLjAKSXBFeHRJbk5vUm91dGVzICAgICAgICAgICAgICAg
ICA0ICAgICAgICAgICAgICAgICAgMC4wCklwRXh0SW5UcnVuY2F0ZWRQa3RzICAgICAgICAgICAg
MCAgICAgICAgICAgICAgICAgIDAuMApJcEV4dEluTWNhc3RQa3RzICAgICAgICAgICAgICAgIDYg
ICAgICAgICAgICAgICAgICAwLjAKSXBFeHRPdXRNY2FzdFBrdHMgICAgICAgICAgICAgICAxNiAg
ICAgICAgICAgICAgICAgMC4wCklwRXh0SW5CY2FzdFBrdHMgICAgICAgICAgICAgICAgMCAgICAg
ICAgICAgICAgICAgIDAuMApJcEV4dE91dEJjYXN0UGt0cyAgICAgICAgICAgICAgIDAgICAgICAg
ICAgICAgICAgICAwLjAKSXBFeHRJbk9jdGV0cyAgICAgICAgICAgICAgICAgICAxMTU2NjcyNTY3
NjgyMDggICAgMC4wCklwRXh0T3V0T2N0ZXRzICAgICAgICAgICAgICAgICAgMjA5OTMzNjg1MTIx
OTAgICAgIDAuMApJcEV4dEluTWNhc3RPY3RldHMgICAgICAgICAgICAgIDMwNiAgICAgICAgICAg
ICAgICAwLjAKSXBFeHRPdXRNY2FzdE9jdGV0cyAgICAgICAgICAgICA3MDYgICAgICAgICAgICAg
ICAgMC4wCklwRXh0SW5CY2FzdE9jdGV0cyAgICAgICAgICAgICAgMCAgICAgICAgICAgICAgICAg
IDAuMApJcEV4dE91dEJjYXN0T2N0ZXRzICAgICAgICAgICAgIDAgICAgICAgICAgICAgICAgICAw
LjAKSXBFeHRJbkNzdW1FcnJvcnMgICAgICAgICAgICAgICAwICAgICAgICAgICAgICAgICAgMC4w
CklwRXh0SW5Ob0VDVFBrdHMgICAgICAgICAgICAgICAgNDE3ODAyMTY1ODMgICAgICAgIDAuMApJ
cEV4dEluRUNUMVBrdHMgICAgICAgICAgICAgICAgIDAgICAgICAgICAgICAgICAgICAwLjAKSXBF
eHRJbkVDVDBQa3RzICAgICAgICAgICAgICAgICAyOTkgICAgICAgICAgICAgICAgMC4wCklwRXh0
SW5DRVBrdHMgICAgICAgICAgICAgICAgICAgMCAgICAgICAgICAgICAgICAgIDAuMApJcEV4dFJl
YXNtT3ZlcmxhcHMgICAgICAgICAgICAgIDAgICAgICAgICAgICAgICAgICAwLjAK
--000000000000a4399406357e7027
Content-Type: text/plain; charset="US-ASCII"; name="nstat_2_51.txt"
Content-Disposition: attachment; filename="nstat_2_51.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_mav7o0aw1>
X-Attachment-Id: f_mav7o0aw1

I2tlcm5lbApJcEluUmVjZWl2ZXMgICAgICAgICAgICAgICAgICAgIDE4Nzg4MDk3MjE0ICAgICAg
ICAwLjAKSXBJbkhkckVycm9ycyAgICAgICAgICAgICAgICAgICA0NzUyMiAgICAgICAgICAgICAg
MC4wCklwSW5BZGRyRXJyb3JzICAgICAgICAgICAgICAgICAgMCAgICAgICAgICAgICAgICAgIDAu
MApJcEZvcndEYXRhZ3JhbXMgICAgICAgICAgICAgICAgIDExNzc4NzQ3ICAgICAgICAgICAwLjAK
SXBJblVua25vd25Qcm90b3MgICAgICAgICAgICAgICAwICAgICAgICAgICAgICAgICAgMC4wCklw
SW5EaXNjYXJkcyAgICAgICAgICAgICAgICAgICAgMCAgICAgICAgICAgICAgICAgIDAuMApJcElu
RGVsaXZlcnMgICAgICAgICAgICAgICAgICAgIDE4Nzc2MjQ4NDM1ICAgICAgICAwLjAKSXBPdXRS
ZXF1ZXN0cyAgICAgICAgICAgICAgICAgICAxNDQyODc5OTkwNyAgICAgICAgMC4wCklwT3V0RGlz
Y2FyZHMgICAgICAgICAgICAgICAgICAgNDA3OTggICAgICAgICAgICAgIDAuMApJcE91dE5vUm91
dGVzICAgICAgICAgICAgICAgICAgIDAgICAgICAgICAgICAgICAgICAwLjAKSXBSZWFzbVRpbWVv
dXQgICAgICAgICAgICAgICAgICAwICAgICAgICAgICAgICAgICAgMC4wCklwUmVhc21SZXFkcyAg
ICAgICAgICAgICAgICAgICAgMzI5NTIgICAgICAgICAgICAgIDAuMApJcFJlYXNtT0tzICAgICAg
ICAgICAgICAgICAgICAgIDE2NDc2ICAgICAgICAgICAgICAwLjAKSXBSZWFzbUZhaWxzICAgICAg
ICAgICAgICAgICAgICAwICAgICAgICAgICAgICAgICAgMC4wCklwRnJhZ09LcyAgICAgICAgICAg
ICAgICAgICAgICAgMCAgICAgICAgICAgICAgICAgIDAuMApJcEZyYWdGYWlscyAgICAgICAgICAg
ICAgICAgICAgIDAgICAgICAgICAgICAgICAgICAwLjAKSXBGcmFnQ3JlYXRlcyAgICAgICAgICAg
ICAgICAgICAwICAgICAgICAgICAgICAgICAgMC4wCklwT3V0VHJhbnNtaXRzICAgICAgICAgICAg
ICAgICAgMTQ0NDA1Mzc5MDAgICAgICAgIDAuMApJY21wSW5Nc2dzICAgICAgICAgICAgICAgICAg
ICAgIDcwNTIxNTQgICAgICAgICAgICAwLjAKSWNtcEluRXJyb3JzICAgICAgICAgICAgICAgICAg
ICAxMDcgICAgICAgICAgICAgICAgMC4wCkljbXBJbkNzdW1FcnJvcnMgICAgICAgICAgICAgICAg
MCAgICAgICAgICAgICAgICAgIDAuMApJY21wSW5EZXN0VW5yZWFjaHMgICAgICAgICAgICAgIDEw
MDIzNyAgICAgICAgICAgICAwLjAKSWNtcEluVGltZUV4Y2RzICAgICAgICAgICAgICAgICAyOTgg
ICAgICAgICAgICAgICAgMC4wCkljbXBJblBhcm1Qcm9icyAgICAgICAgICAgICAgICAgMCAgICAg
ICAgICAgICAgICAgIDAuMApJY21wSW5TcmNRdWVuY2hzICAgICAgICAgICAgICAgIDAgICAgICAg
ICAgICAgICAgICAwLjAKSWNtcEluUmVkaXJlY3RzICAgICAgICAgICAgICAgICA2NyAgICAgICAg
ICAgICAgICAgMC4wCkljbXBJbkVjaG9zICAgICAgICAgICAgICAgICAgICAgNDAzNTg0OSAgICAg
ICAgICAgIDAuMApJY21wSW5FY2hvUmVwcyAgICAgICAgICAgICAgICAgIDI5MTU3MDMgICAgICAg
ICAgICAwLjAKSWNtcEluVGltZXN0YW1wcyAgICAgICAgICAgICAgICAwICAgICAgICAgICAgICAg
ICAgMC4wCkljbXBJblRpbWVzdGFtcFJlcHMgICAgICAgICAgICAgMCAgICAgICAgICAgICAgICAg
IDAuMApJY21wSW5BZGRyTWFza3MgICAgICAgICAgICAgICAgIDAgICAgICAgICAgICAgICAgICAw
LjAKSWNtcEluQWRkck1hc2tSZXBzICAgICAgICAgICAgICAwICAgICAgICAgICAgICAgICAgMC4w
CkljbXBPdXRNc2dzICAgICAgICAgICAgICAgICAgICAgNzA2MTk2NyAgICAgICAgICAgIDAuMApJ
Y21wT3V0RXJyb3JzICAgICAgICAgICAgICAgICAgIDAgICAgICAgICAgICAgICAgICAwLjAKSWNt
cE91dFJhdGVMaW1pdEdsb2JhbCAgICAgICAgICAwICAgICAgICAgICAgICAgICAgMC4wCkljbXBP
dXRSYXRlTGltaXRIb3N0ICAgICAgICAgICAgNDcwODcgICAgICAgICAgICAgIDAuMApJY21wT3V0
RGVzdFVucmVhY2hzICAgICAgICAgICAgIDEwNDIxICAgICAgICAgICAgICAwLjAKSWNtcE91dFRp
bWVFeGNkcyAgICAgICAgICAgICAgICA0NDkgICAgICAgICAgICAgICAgMC4wCkljbXBPdXRQYXJt
UHJvYnMgICAgICAgICAgICAgICAgMCAgICAgICAgICAgICAgICAgIDAuMApJY21wT3V0U3JjUXVl
bmNocyAgICAgICAgICAgICAgIDAgICAgICAgICAgICAgICAgICAwLjAKSWNtcE91dFJlZGlyZWN0
cyAgICAgICAgICAgICAgICA0NjIxNiAgICAgICAgICAgICAgMC4wCkljbXBPdXRFY2hvcyAgICAg
ICAgICAgICAgICAgICAgMjk2OTAzMiAgICAgICAgICAgIDAuMApJY21wT3V0RWNob1JlcHMgICAg
ICAgICAgICAgICAgIDQwMzU4NDkgICAgICAgICAgICAwLjAKSWNtcE91dFRpbWVzdGFtcHMgICAg
ICAgICAgICAgICAwICAgICAgICAgICAgICAgICAgMC4wCkljbXBPdXRUaW1lc3RhbXBSZXBzICAg
ICAgICAgICAgMCAgICAgICAgICAgICAgICAgIDAuMApJY21wT3V0QWRkck1hc2tzICAgICAgICAg
ICAgICAgIDAgICAgICAgICAgICAgICAgICAwLjAKSWNtcE91dEFkZHJNYXNrUmVwcyAgICAgICAg
ICAgICAwICAgICAgICAgICAgICAgICAgMC4wCkljbXBNc2dJblR5cGUwICAgICAgICAgICAgICAg
ICAgMjkxNTcwMyAgICAgICAgICAgIDAuMApJY21wTXNnSW5UeXBlMyAgICAgICAgICAgICAgICAg
IDEwMDIzNyAgICAgICAgICAgICAwLjAKSWNtcE1zZ0luVHlwZTUgICAgICAgICAgICAgICAgICA2
NyAgICAgICAgICAgICAgICAgMC4wCkljbXBNc2dJblR5cGU4ICAgICAgICAgICAgICAgICAgNDAz
NTg0OSAgICAgICAgICAgIDAuMApJY21wTXNnSW5UeXBlMTEgICAgICAgICAgICAgICAgIDI5OCAg
ICAgICAgICAgICAgICAwLjAKSWNtcE1zZ091dFR5cGUwICAgICAgICAgICAgICAgICA0MDM1ODQ5
ICAgICAgICAgICAgMC4wCkljbXBNc2dPdXRUeXBlMyAgICAgICAgICAgICAgICAgMTA0MjEgICAg
ICAgICAgICAgIDAuMApJY21wTXNnT3V0VHlwZTUgICAgICAgICAgICAgICAgIDQ2MjE2ICAgICAg
ICAgICAgICAwLjAKSWNtcE1zZ091dFR5cGU4ICAgICAgICAgICAgICAgICAyOTY5MDMyICAgICAg
ICAgICAgMC4wCkljbXBNc2dPdXRUeXBlMTEgICAgICAgICAgICAgICAgNDQ5ICAgICAgICAgICAg
ICAgIDAuMApUY3BBY3RpdmVPcGVucyAgICAgICAgICAgICAgICAgIDc5MDI5MzIgICAgICAgICAg
ICAwLjAKVGNwUGFzc2l2ZU9wZW5zICAgICAgICAgICAgICAgICAxNDQ3MTQ2ICAgICAgICAgICAg
MC4wClRjcEF0dGVtcHRGYWlscyAgICAgICAgICAgICAgICAgNDE2MDUgICAgICAgICAgICAgIDAu
MApUY3BFc3RhYlJlc2V0cyAgICAgICAgICAgICAgICAgIDEzMjcwNDYgICAgICAgICAgICAwLjAK
VGNwSW5TZWdzICAgICAgICAgICAgICAgICAgICAgICA0OTUzMDc1NDc1ICAgICAgICAgMC4wClRj
cE91dFNlZ3MgICAgICAgICAgICAgICAgICAgICAgMjk4ODA2NjkyOCAgICAgICAgIDAuMApUY3BS
ZXRyYW5zU2VncyAgICAgICAgICAgICAgICAgIDY1NjE4NyAgICAgICAgICAgICAwLjAKVGNwSW5F
cnJzICAgICAgICAgICAgICAgICAgICAgICAwICAgICAgICAgICAgICAgICAgMC4wClRjcE91dFJz
dHMgICAgICAgICAgICAgICAgICAgICAgMzQwMTg2NiAgICAgICAgICAgIDAuMApUY3BJbkNzdW1F
cnJvcnMgICAgICAgICAgICAgICAgIDAgICAgICAgICAgICAgICAgICAwLjAKVWRwSW5EYXRhZ3Jh
bXMgICAgICAgICAgICAgICAgICAxMzgxNjE3MzA1NCAgICAgICAgMC4wClVkcE5vUG9ydHMgICAg
ICAgICAgICAgICAgICAgICAgMTA0MzUgICAgICAgICAgICAgIDAuMApVZHBJbkVycm9ycyAgICAg
ICAgICAgICAgICAgICAgIDIgICAgICAgICAgICAgICAgICAwLjAKVWRwT3V0RGF0YWdyYW1zICAg
ICAgICAgICAgICAgICA0OTMyMTIyNzMgICAgICAgICAgMC4wClVkcFJjdmJ1ZkVycm9ycyAgICAg
ICAgICAgICAgICAgMCAgICAgICAgICAgICAgICAgIDAuMApVZHBTbmRidWZFcnJvcnMgICAgICAg
ICAgICAgICAgIDEwICAgICAgICAgICAgICAgICAwLjAKVWRwSW5Dc3VtRXJyb3JzICAgICAgICAg
ICAgICAgICAwICAgICAgICAgICAgICAgICAgMC4wClVkcElnbm9yZWRNdWx0aSAgICAgICAgICAg
ICAgICAgMCAgICAgICAgICAgICAgICAgIDAuMApVZHBNZW1FcnJvcnMgICAgICAgICAgICAgICAg
ICAgIDAgICAgICAgICAgICAgICAgICAwLjAKVWRwTGl0ZUluRGF0YWdyYW1zICAgICAgICAgICAg
ICAwICAgICAgICAgICAgICAgICAgMC4wClVkcExpdGVOb1BvcnRzICAgICAgICAgICAgICAgICAg
MCAgICAgICAgICAgICAgICAgIDAuMApVZHBMaXRlSW5FcnJvcnMgICAgICAgICAgICAgICAgIDAg
ICAgICAgICAgICAgICAgICAwLjAKVWRwTGl0ZU91dERhdGFncmFtcyAgICAgICAgICAgICAwICAg
ICAgICAgICAgICAgICAgMC4wClVkcExpdGVSY3ZidWZFcnJvcnMgICAgICAgICAgICAgMCAgICAg
ICAgICAgICAgICAgIDAuMApVZHBMaXRlU25kYnVmRXJyb3JzICAgICAgICAgICAgIDAgICAgICAg
ICAgICAgICAgICAwLjAKVWRwTGl0ZUluQ3N1bUVycm9ycyAgICAgICAgICAgICAwICAgICAgICAg
ICAgICAgICAgMC4wClVkcExpdGVJZ25vcmVkTXVsdGkgICAgICAgICAgICAgMCAgICAgICAgICAg
ICAgICAgIDAuMApVZHBMaXRlTWVtRXJyb3JzICAgICAgICAgICAgICAgIDAgICAgICAgICAgICAg
ICAgICAwLjAKSXA2SW5SZWNlaXZlcyAgICAgICAgICAgICAgICAgICAyNjgyODAgICAgICAgICAg
ICAgMC4wCklwNkluSGRyRXJyb3JzICAgICAgICAgICAgICAgICAgMCAgICAgICAgICAgICAgICAg
IDAuMApJcDZJblRvb0JpZ0Vycm9ycyAgICAgICAgICAgICAgIDAgICAgICAgICAgICAgICAgICAw
LjAKSXA2SW5Ob1JvdXRlcyAgICAgICAgICAgICAgICAgICAzOSAgICAgICAgICAgICAgICAgMC4w
CklwNkluQWRkckVycm9ycyAgICAgICAgICAgICAgICAgMCAgICAgICAgICAgICAgICAgIDAuMApJ
cDZJblVua25vd25Qcm90b3MgICAgICAgICAgICAgIDAgICAgICAgICAgICAgICAgICAwLjAKSXA2
SW5UcnVuY2F0ZWRQa3RzICAgICAgICAgICAgICAwICAgICAgICAgICAgICAgICAgMC4wCklwNklu
RGlzY2FyZHMgICAgICAgICAgICAgICAgICAgMCAgICAgICAgICAgICAgICAgIDAuMApJcDZJbkRl
bGl2ZXJzICAgICAgICAgICAgICAgICAgIDg1ODYyICAgICAgICAgICAgICAwLjAKSXA2T3V0Rm9y
d0RhdGFncmFtcyAgICAgICAgICAgICAwICAgICAgICAgICAgICAgICAgMC4wCklwNk91dFJlcXVl
c3RzICAgICAgICAgICAgICAgICAgNTAwMTk3ICAgICAgICAgICAgIDAuMApJcDZPdXREaXNjYXJk
cyAgICAgICAgICAgICAgICAgIDEgICAgICAgICAgICAgICAgICAwLjAKSXA2T3V0Tm9Sb3V0ZXMg
ICAgICAgICAgICAgICAgICA1OTEgICAgICAgICAgICAgICAgMC4wCklwNlJlYXNtVGltZW91dCAg
ICAgICAgICAgICAgICAgMCAgICAgICAgICAgICAgICAgIDAuMApJcDZSZWFzbVJlcWRzICAgICAg
ICAgICAgICAgICAgIDAgICAgICAgICAgICAgICAgICAwLjAKSXA2UmVhc21PS3MgICAgICAgICAg
ICAgICAgICAgICAwICAgICAgICAgICAgICAgICAgMC4wCklwNlJlYXNtRmFpbHMgICAgICAgICAg
ICAgICAgICAgMCAgICAgICAgICAgICAgICAgIDAuMApJcDZGcmFnT0tzICAgICAgICAgICAgICAg
ICAgICAgIDAgICAgICAgICAgICAgICAgICAwLjAKSXA2RnJhZ0ZhaWxzICAgICAgICAgICAgICAg
ICAgICAwICAgICAgICAgICAgICAgICAgMC4wCklwNkZyYWdDcmVhdGVzICAgICAgICAgICAgICAg
ICAgMCAgICAgICAgICAgICAgICAgIDAuMApJcDZJbk1jYXN0UGt0cyAgICAgICAgICAgICAgICAg
IDE5NDcyNyAgICAgICAgICAgICAwLjAKSXA2T3V0TWNhc3RQa3RzICAgICAgICAgICAgICAgICA0
MjY1NjIgICAgICAgICAgICAgMC4wCklwNkluT2N0ZXRzICAgICAgICAgICAgICAgICAgICAgMjAx
NzMwMDUgICAgICAgICAgIDAuMApJcDZPdXRPY3RldHMgICAgICAgICAgICAgICAgICAgIDQ1MzU5
MDY4ICAgICAgICAgICAwLjAKSXA2SW5NY2FzdE9jdGV0cyAgICAgICAgICAgICAgICAxNDM0NTQ5
NCAgICAgICAgICAgMC4wCklwNk91dE1jYXN0T2N0ZXRzICAgICAgICAgICAgICAgMzk0NDA3OTAg
ICAgICAgICAgIDAuMApJcDZJbkJjYXN0T2N0ZXRzICAgICAgICAgICAgICAgIDAgICAgICAgICAg
ICAgICAgICAwLjAKSXA2T3V0QmNhc3RPY3RldHMgICAgICAgICAgICAgICAwICAgICAgICAgICAg
ICAgICAgMC4wCklwNkluTm9FQ1RQa3RzICAgICAgICAgICAgICAgICAgMjY4MjgwICAgICAgICAg
ICAgIDAuMApJcDZJbkVDVDFQa3RzICAgICAgICAgICAgICAgICAgIDAgICAgICAgICAgICAgICAg
ICAwLjAKSXA2SW5FQ1QwUGt0cyAgICAgICAgICAgICAgICAgICAwICAgICAgICAgICAgICAgICAg
MC4wCklwNkluQ0VQa3RzICAgICAgICAgICAgICAgICAgICAgMCAgICAgICAgICAgICAgICAgIDAu
MApJcDZPdXRUcmFuc21pdHMgICAgICAgICAgICAgICAgIDUwMDE5NyAgICAgICAgICAgICAwLjAK
SWNtcDZJbk1zZ3MgICAgICAgICAgICAgICAgICAgICAyMzE3NiAgICAgICAgICAgICAgMC4wCklj
bXA2SW5FcnJvcnMgICAgICAgICAgICAgICAgICAgMCAgICAgICAgICAgICAgICAgIDAuMApJY21w
Nk91dE1zZ3MgICAgICAgICAgICAgICAgICAgIDQzNzM4OSAgICAgICAgICAgICAwLjAKSWNtcDZP
dXRFcnJvcnMgICAgICAgICAgICAgICAgICAwICAgICAgICAgICAgICAgICAgMC4wCkljbXA2SW5D
c3VtRXJyb3JzICAgICAgICAgICAgICAgMCAgICAgICAgICAgICAgICAgIDAuMApJY21wNk91dFJh
dGVMaW1pdEhvc3QgICAgICAgICAgIDAgICAgICAgICAgICAgICAgICAwLjAKSWNtcDZJbkRlc3RV
bnJlYWNocyAgICAgICAgICAgICAwICAgICAgICAgICAgICAgICAgMC4wCkljbXA2SW5Qa3RUb29C
aWdzICAgICAgICAgICAgICAgMCAgICAgICAgICAgICAgICAgIDAuMApJY21wNkluVGltZUV4Y2Rz
ICAgICAgICAgICAgICAgIDAgICAgICAgICAgICAgICAgICAwLjAKSWNtcDZJblBhcm1Qcm9ibGVt
cyAgICAgICAgICAgICAwICAgICAgICAgICAgICAgICAgMC4wCkljbXA2SW5FY2hvcyAgICAgICAg
ICAgICAgICAgICAgMCAgICAgICAgICAgICAgICAgIDAuMApJY21wNkluRWNob1JlcGxpZXMgICAg
ICAgICAgICAgIDAgICAgICAgICAgICAgICAgICAwLjAKSWNtcDZJbkdyb3VwTWVtYlF1ZXJpZXMg
ICAgICAgICAwICAgICAgICAgICAgICAgICAgMC4wCkljbXA2SW5Hcm91cE1lbWJSZXNwb25zZXMg
ICAgICAgMCAgICAgICAgICAgICAgICAgIDAuMApJY21wNkluR3JvdXBNZW1iUmVkdWN0aW9ucyAg
ICAgIDAgICAgICAgICAgICAgICAgICAwLjAKSWNtcDZJblJvdXRlclNvbGljaXRzICAgICAgICAg
ICAxMjMzOSAgICAgICAgICAgICAgMC4wCkljbXA2SW5Sb3V0ZXJBZHZlcnRpc2VtZW50cyAgICAg
MCAgICAgICAgICAgICAgICAgIDAuMApJY21wNkluTmVpZ2hib3JTb2xpY2l0cyAgICAgICAgIDIx
MTcgICAgICAgICAgICAgICAwLjAKSWNtcDZJbk5laWdoYm9yQWR2ZXJ0aXNlbWVudHMgICA4NzIw
ICAgICAgICAgICAgICAgMC4wCkljbXA2SW5SZWRpcmVjdHMgICAgICAgICAgICAgICAgMCAgICAg
ICAgICAgICAgICAgIDAuMApJY21wNkluTUxEdjJSZXBvcnRzICAgICAgICAgICAgIDAgICAgICAg
ICAgICAgICAgICAwLjAKSWNtcDZPdXREZXN0VW5yZWFjaHMgICAgICAgICAgICAwICAgICAgICAg
ICAgICAgICAgMC4wCkljbXA2T3V0UGt0VG9vQmlncyAgICAgICAgICAgICAgMCAgICAgICAgICAg
ICAgICAgIDAuMApJY21wNk91dFRpbWVFeGNkcyAgICAgICAgICAgICAgIDAgICAgICAgICAgICAg
ICAgICAwLjAKSWNtcDZPdXRQYXJtUHJvYmxlbXMgICAgICAgICAgICAwICAgICAgICAgICAgICAg
ICAgMC4wCkljbXA2T3V0RWNob3MgICAgICAgICAgICAgICAgICAgMCAgICAgICAgICAgICAgICAg
IDAuMApJY21wNk91dEVjaG9SZXBsaWVzICAgICAgICAgICAgIDAgICAgICAgICAgICAgICAgICAw
LjAKSWNtcDZPdXRHcm91cE1lbWJRdWVyaWVzICAgICAgICAwICAgICAgICAgICAgICAgICAgMC4w
CkljbXA2T3V0R3JvdXBNZW1iUmVzcG9uc2VzICAgICAgMCAgICAgICAgICAgICAgICAgIDAuMApJ
Y21wNk91dEdyb3VwTWVtYlJlZHVjdGlvbnMgICAgIDAgICAgICAgICAgICAgICAgICAwLjAKSWNt
cDZPdXRSb3V0ZXJTb2xpY2l0cyAgICAgICAgICAyICAgICAgICAgICAgICAgICAgMC4wCkljbXA2
T3V0Um91dGVyQWR2ZXJ0aXNlbWVudHMgICAgMCAgICAgICAgICAgICAgICAgIDAuMApJY21wNk91
dE5laWdoYm9yU29saWNpdHMgICAgICAgIDY5NDc2ICAgICAgICAgICAgICAwLjAKSWNtcDZPdXRO
ZWlnaGJvckFkdmVydGlzZW1lbnRzICAyMTE2ICAgICAgICAgICAgICAgMC4wCkljbXA2T3V0UmVk
aXJlY3RzICAgICAgICAgICAgICAgMCAgICAgICAgICAgICAgICAgIDAuMApJY21wNk91dE1MRHYy
UmVwb3J0cyAgICAgICAgICAgIDM2NTc5NSAgICAgICAgICAgICAwLjAKSWNtcDZJblR5cGUxMzMg
ICAgICAgICAgICAgICAgICAxMjMzOSAgICAgICAgICAgICAgMC4wCkljbXA2SW5UeXBlMTM1ICAg
ICAgICAgICAgICAgICAgMjExNyAgICAgICAgICAgICAgIDAuMApJY21wNkluVHlwZTEzNiAgICAg
ICAgICAgICAgICAgIDg3MjAgICAgICAgICAgICAgICAwLjAKSWNtcDZPdXRUeXBlMTMzICAgICAg
ICAgICAgICAgICAyICAgICAgICAgICAgICAgICAgMC4wCkljbXA2T3V0VHlwZTEzNSAgICAgICAg
ICAgICAgICAgNjk0NzYgICAgICAgICAgICAgIDAuMApJY21wNk91dFR5cGUxMzYgICAgICAgICAg
ICAgICAgIDIxMTYgICAgICAgICAgICAgICAwLjAKSWNtcDZPdXRUeXBlMTQzICAgICAgICAgICAg
ICAgICAzNjU3OTUgICAgICAgICAgICAgMC4wClVkcDZJbkRhdGFncmFtcyAgICAgICAgICAgICAg
ICAgNiAgICAgICAgICAgICAgICAgIDAuMApVZHA2Tm9Qb3J0cyAgICAgICAgICAgICAgICAgICAg
IDAgICAgICAgICAgICAgICAgICAwLjAKVWRwNkluRXJyb3JzICAgICAgICAgICAgICAgICAgICAw
ICAgICAgICAgICAgICAgICAgMC4wClVkcDZPdXREYXRhZ3JhbXMgICAgICAgICAgICAgICAgNiAg
ICAgICAgICAgICAgICAgIDAuMApVZHA2UmN2YnVmRXJyb3JzICAgICAgICAgICAgICAgIDAgICAg
ICAgICAgICAgICAgICAwLjAKVWRwNlNuZGJ1ZkVycm9ycyAgICAgICAgICAgICAgICAwICAgICAg
ICAgICAgICAgICAgMC4wClVkcDZJbkNzdW1FcnJvcnMgICAgICAgICAgICAgICAgMCAgICAgICAg
ICAgICAgICAgIDAuMApVZHA2SWdub3JlZE11bHRpICAgICAgICAgICAgICAgIDAgICAgICAgICAg
ICAgICAgICAwLjAKVWRwNk1lbUVycm9ycyAgICAgICAgICAgICAgICAgICAwICAgICAgICAgICAg
ICAgICAgMC4wClVkcExpdGU2SW5EYXRhZ3JhbXMgICAgICAgICAgICAgMCAgICAgICAgICAgICAg
ICAgIDAuMApVZHBMaXRlNk5vUG9ydHMgICAgICAgICAgICAgICAgIDAgICAgICAgICAgICAgICAg
ICAwLjAKVWRwTGl0ZTZJbkVycm9ycyAgICAgICAgICAgICAgICAwICAgICAgICAgICAgICAgICAg
MC4wClVkcExpdGU2T3V0RGF0YWdyYW1zICAgICAgICAgICAgMCAgICAgICAgICAgICAgICAgIDAu
MApVZHBMaXRlNlJjdmJ1ZkVycm9ycyAgICAgICAgICAgIDAgICAgICAgICAgICAgICAgICAwLjAK
VWRwTGl0ZTZTbmRidWZFcnJvcnMgICAgICAgICAgICAwICAgICAgICAgICAgICAgICAgMC4wClVk
cExpdGU2SW5Dc3VtRXJyb3JzICAgICAgICAgICAgMCAgICAgICAgICAgICAgICAgIDAuMApVZHBM
aXRlNk1lbUVycm9ycyAgICAgICAgICAgICAgIDAgICAgICAgICAgICAgICAgICAwLjAKVGNwRXh0
U3luY29va2llc1NlbnQgICAgICAgICAgICAwICAgICAgICAgICAgICAgICAgMC4wClRjcEV4dFN5
bmNvb2tpZXNSZWN2ICAgICAgICAgICAgMCAgICAgICAgICAgICAgICAgIDAuMApUY3BFeHRTeW5j
b29raWVzRmFpbGVkICAgICAgICAgIDAgICAgICAgICAgICAgICAgICAwLjAKVGNwRXh0RW1icnlv
bmljUnN0cyAgICAgICAgICAgICAzICAgICAgICAgICAgICAgICAgMC4wClRjcEV4dFBydW5lQ2Fs
bGVkICAgICAgICAgICAgICAgMzg5MSAgICAgICAgICAgICAgIDAuMApUY3BFeHRSY3ZQcnVuZWQg
ICAgICAgICAgICAgICAgIDAgICAgICAgICAgICAgICAgICAwLjAKVGNwRXh0T2ZvUHJ1bmVkICAg
ICAgICAgICAgICAgICAwICAgICAgICAgICAgICAgICAgMC4wClRjcEV4dE91dE9mV2luZG93SWNt
cHMgICAgICAgICAgMTAgICAgICAgICAgICAgICAgIDAuMApUY3BFeHRMb2NrRHJvcHBlZEljbXBz
ICAgICAgICAgIDE3OCAgICAgICAgICAgICAgICAwLjAKVGNwRXh0QXJwRmlsdGVyICAgICAgICAg
ICAgICAgICAwICAgICAgICAgICAgICAgICAgMC4wClRjcEV4dFRXICAgICAgICAgICAgICAgICAg
ICAgICAgMzU4MzE2MCAgICAgICAgICAgIDAuMApUY3BFeHRUV1JlY3ljbGVkICAgICAgICAgICAg
ICAgIDQyMTcgICAgICAgICAgICAgICAwLjAKVGNwRXh0VFdLaWxsZWQgICAgICAgICAgICAgICAg
ICAwICAgICAgICAgICAgICAgICAgMC4wClRjcEV4dFBBV1NBY3RpdmUgICAgICAgICAgICAgICAg
MCAgICAgICAgICAgICAgICAgIDAuMApUY3BFeHRQQVdTRXN0YWIgICAgICAgICAgICAgICAgIDYw
ICAgICAgICAgICAgICAgICAwLjAKVGNwRXh0RGVsYXllZEFDS3MgICAgICAgICAgICAgICA1MTMz
NDE2ICAgICAgICAgICAgMC4wClRjcEV4dERlbGF5ZWRBQ0tMb2NrZWQgICAgICAgICAgMzAwOCAg
ICAgICAgICAgICAgIDAuMApUY3BFeHREZWxheWVkQUNLTG9zdCAgICAgICAgICAgIDExMTE2NSAg
ICAgICAgICAgICAwLjAKVGNwRXh0TGlzdGVuT3ZlcmZsb3dzICAgICAgICAgICAwICAgICAgICAg
ICAgICAgICAgMC4wClRjcEV4dExpc3RlbkRyb3BzICAgICAgICAgICAgICAgMCAgICAgICAgICAg
ICAgICAgIDAuMApUY3BFeHRUQ1BIUEhpdHMgICAgICAgICAgICAgICAgIDIwMjM0MTMgICAgICAg
ICAgICAwLjAKVGNwRXh0VENQUHVyZUFja3MgICAgICAgICAgICAgICA1MzA4NzcxMyAgICAgICAg
ICAgMC4wClRjcEV4dFRDUEhQQWNrcyAgICAgICAgICAgICAgICAgMTE1MzQwMjExICAgICAgICAg
IDAuMApUY3BFeHRUQ1BSZW5vUmVjb3ZlcnkgICAgICAgICAgIDAgICAgICAgICAgICAgICAgICAw
LjAKVGNwRXh0VENQU2Fja1JlY292ZXJ5ICAgICAgICAgICAxMzM5NiAgICAgICAgICAgICAgMC4w
ClRjcEV4dFRDUFNBQ0tSZW5lZ2luZyAgICAgICAgICAgMCAgICAgICAgICAgICAgICAgIDAuMApU
Y3BFeHRUQ1BTQUNLUmVvcmRlciAgICAgICAgICAgIDIwMiAgICAgICAgICAgICAgICAwLjAKVGNw
RXh0VENQUmVub1Jlb3JkZXIgICAgICAgICAgICAwICAgICAgICAgICAgICAgICAgMC4wClRjcEV4
dFRDUFRTUmVvcmRlciAgICAgICAgICAgICAgMSAgICAgICAgICAgICAgICAgIDAuMApUY3BFeHRU
Q1BGdWxsVW5kbyAgICAgICAgICAgICAgIDAgICAgICAgICAgICAgICAgICAwLjAKVGNwRXh0VENQ
UGFydGlhbFVuZG8gICAgICAgICAgICAxICAgICAgICAgICAgICAgICAgMC4wClRjcEV4dFRDUERT
QUNLVW5kbyAgICAgICAgICAgICAgMjUyICAgICAgICAgICAgICAgIDAuMApUY3BFeHRUQ1BMb3Nz
VW5kbyAgICAgICAgICAgICAgIDg1ICAgICAgICAgICAgICAgICAwLjAKVGNwRXh0VENQTG9zdFJl
dHJhbnNtaXQgICAgICAgICAxOTU3MTggICAgICAgICAgICAgMC4wClRjcEV4dFRDUFJlbm9GYWls
dXJlcyAgICAgICAgICAgMCAgICAgICAgICAgICAgICAgIDAuMApUY3BFeHRUQ1BTYWNrRmFpbHVy
ZXMgICAgICAgICAgIDMgICAgICAgICAgICAgICAgICAwLjAKVGNwRXh0VENQTG9zc0ZhaWx1cmVz
ICAgICAgICAgICAwICAgICAgICAgICAgICAgICAgMC4wClRjcEV4dFRDUEZhc3RSZXRyYW5zICAg
ICAgICAgICAgMzgxOTc2ICAgICAgICAgICAgIDAuMApUY3BFeHRUQ1BTbG93U3RhcnRSZXRyYW5z
ICAgICAgIDc2ICAgICAgICAgICAgICAgICAwLjAKVGNwRXh0VENQVGltZW91dHMgICAgICAgICAg
ICAgICAxOTUzODcgICAgICAgICAgICAgMC4wClRjcEV4dFRDUExvc3NQcm9iZXMgICAgICAgICAg
ICAgMTEwODYzICAgICAgICAgICAgIDAuMApUY3BFeHRUQ1BMb3NzUHJvYmVSZWNvdmVyeSAgICAg
IDc3MyAgICAgICAgICAgICAgICAwLjAKVGNwRXh0VENQUmVub1JlY292ZXJ5RmFpbCAgICAgICAw
ICAgICAgICAgICAgICAgICAgMC4wClRjcEV4dFRDUFNhY2tSZWNvdmVyeUZhaWwgICAgICAgMzgg
ICAgICAgICAgICAgICAgIDAuMApUY3BFeHRUQ1BSY3ZDb2xsYXBzZWQgICAgICAgICAgIDI5NjAg
ICAgICAgICAgICAgICAwLjAKVGNwRXh0VENQQmFja2xvZ0NvYWxlc2NlICAgICAgICAyNTI4NDA3
NTkgICAgICAgICAgMC4wClRjcEV4dFRDUERTQUNLT2xkU2VudCAgICAgICAgICAgMTExMjE2ICAg
ICAgICAgICAgIDAuMApUY3BFeHRUQ1BEU0FDS09mb1NlbnQgICAgICAgICAgIDIgICAgICAgICAg
ICAgICAgICAwLjAKVGNwRXh0VENQRFNBQ0tSZWN2ICAgICAgICAgICAgICA3NzUyMyAgICAgICAg
ICAgICAgMC4wClRjcEV4dFRDUERTQUNLT2ZvUmVjdiAgICAgICAgICAgMyAgICAgICAgICAgICAg
ICAgIDAuMApUY3BFeHRUQ1BBYm9ydE9uRGF0YSAgICAgICAgICAgIDUwOTU3NyAgICAgICAgICAg
ICAwLjAKVGNwRXh0VENQQWJvcnRPbkNsb3NlICAgICAgICAgICAxMjQ2NjI2ICAgICAgICAgICAg
MC4wClRjcEV4dFRDUEFib3J0T25NZW1vcnkgICAgICAgICAgMCAgICAgICAgICAgICAgICAgIDAu
MApUY3BFeHRUQ1BBYm9ydE9uVGltZW91dCAgICAgICAgIDMyICAgICAgICAgICAgICAgICAwLjAK
VGNwRXh0VENQQWJvcnRPbkxpbmdlciAgICAgICAgICAwICAgICAgICAgICAgICAgICAgMC4wClRj
cEV4dFRDUEFib3J0RmFpbGVkICAgICAgICAgICAgMCAgICAgICAgICAgICAgICAgIDAuMApUY3BF
eHRUQ1BNZW1vcnlQcmVzc3VyZXMgICAgICAgIDAgICAgICAgICAgICAgICAgICAwLjAKVGNwRXh0
VENQTWVtb3J5UHJlc3N1cmVzQ2hyb25vICAwICAgICAgICAgICAgICAgICAgMC4wClRjcEV4dFRD
UFNBQ0tEaXNjYXJkICAgICAgICAgICAgMTAgICAgICAgICAgICAgICAgIDAuMApUY3BFeHRUQ1BE
U0FDS0lnbm9yZWRPbGQgICAgICAgIDIgICAgICAgICAgICAgICAgICAwLjAKVGNwRXh0VENQRFNB
Q0tJZ25vcmVkTm9VbmRvICAgICA3MzMxMCAgICAgICAgICAgICAgMC4wClRjcEV4dFRDUFNwdXJp
b3VzUlRPcyAgICAgICAgICAgMjMgICAgICAgICAgICAgICAgIDAuMApUY3BFeHRUQ1BNRDVOb3RG
b3VuZCAgICAgICAgICAgIDAgICAgICAgICAgICAgICAgICAwLjAKVGNwRXh0VENQTUQ1VW5leHBl
Y3RlZCAgICAgICAgICAwICAgICAgICAgICAgICAgICAgMC4wClRjcEV4dFRDUE1ENUZhaWx1cmUg
ICAgICAgICAgICAgMCAgICAgICAgICAgICAgICAgIDAuMApUY3BFeHRUQ1BTYWNrU2hpZnRlZCAg
ICAgICAgICAgIDQ1OTc1ICAgICAgICAgICAgICAwLjAKVGNwRXh0VENQU2Fja01lcmdlZCAgICAg
ICAgICAgICAyNDgyMDcgICAgICAgICAgICAgMC4wClRjcEV4dFRDUFNhY2tTaGlmdEZhbGxiYWNr
ICAgICAgMzI4MjU3ICAgICAgICAgICAgIDAuMApUY3BFeHRUQ1BCYWNrbG9nRHJvcCAgICAgICAg
ICAgIDAgICAgICAgICAgICAgICAgICAwLjAKVGNwRXh0UEZNZW1hbGxvY0Ryb3AgICAgICAgICAg
ICAwICAgICAgICAgICAgICAgICAgMC4wClRjcEV4dFRDUE1pblRUTERyb3AgICAgICAgICAgICAg
MCAgICAgICAgICAgICAgICAgIDAuMApUY3BFeHRUQ1BEZWZlckFjY2VwdERyb3AgICAgICAgIDAg
ICAgICAgICAgICAgICAgICAwLjAKVGNwRXh0SVBSZXZlcnNlUGF0aEZpbHRlciAgICAgICAwICAg
ICAgICAgICAgICAgICAgMC4wClRjcEV4dFRDUFRpbWVXYWl0T3ZlcmZsb3cgICAgICAgMCAgICAg
ICAgICAgICAgICAgIDAuMApUY3BFeHRUQ1BSZXFRRnVsbERvQ29va2llcyAgICAgIDAgICAgICAg
ICAgICAgICAgICAwLjAKVGNwRXh0VENQUmVxUUZ1bGxEcm9wICAgICAgICAgICAwICAgICAgICAg
ICAgICAgICAgMC4wClRjcEV4dFRDUFJldHJhbnNGYWlsICAgICAgICAgICAgNTUgICAgICAgICAg
ICAgICAgIDAuMApUY3BFeHRUQ1BSY3ZDb2FsZXNjZSAgICAgICAgICAgIDE1NzUxODEzODAgICAg
ICAgICAwLjAKVGNwRXh0VENQT0ZPUXVldWUgICAgICAgICAgICAgICAyNjYxMzYzICAgICAgICAg
ICAgMC4wClRjcEV4dFRDUE9GT0Ryb3AgICAgICAgICAgICAgICAgMCAgICAgICAgICAgICAgICAg
IDAuMApUY3BFeHRUQ1BPRk9NZXJnZSAgICAgICAgICAgICAgIDIgICAgICAgICAgICAgICAgICAw
LjAKVGNwRXh0VENQQ2hhbGxlbmdlQUNLICAgICAgICAgICAxMzggICAgICAgICAgICAgICAgMC4w
ClRjcEV4dFRDUFNZTkNoYWxsZW5nZSAgICAgICAgICAgODcgICAgICAgICAgICAgICAgIDAuMApU
Y3BFeHRUQ1BGYXN0T3BlbkFjdGl2ZSAgICAgICAgIDAgICAgICAgICAgICAgICAgICAwLjAKVGNw
RXh0VENQRmFzdE9wZW5BY3RpdmVGYWlsICAgICAwICAgICAgICAgICAgICAgICAgMC4wClRjcEV4
dFRDUEZhc3RPcGVuUGFzc2l2ZSAgICAgICAgMCAgICAgICAgICAgICAgICAgIDAuMApUY3BFeHRU
Q1BGYXN0T3BlblBhc3NpdmVGYWlsICAgIDAgICAgICAgICAgICAgICAgICAwLjAKVGNwRXh0VENQ
RmFzdE9wZW5MaXN0ZW5PdmVyZmxvdyAwICAgICAgICAgICAgICAgICAgMC4wClRjcEV4dFRDUEZh
c3RPcGVuQ29va2llUmVxZCAgICAgMCAgICAgICAgICAgICAgICAgIDAuMApUY3BFeHRUQ1BGYXN0
T3BlbkJsYWNraG9sZSAgICAgIDAgICAgICAgICAgICAgICAgICAwLjAKVGNwRXh0VENQU3B1cmlv
dXNSdHhIb3N0UXVldWVzICAxMTggICAgICAgICAgICAgICAgMC4wClRjcEV4dEJ1c3lQb2xsUnhQ
YWNrZXRzICAgICAgICAgMCAgICAgICAgICAgICAgICAgIDAuMApUY3BFeHRUQ1BBdXRvQ29ya2lu
ZyAgICAgICAgICAgIDIwNDAwNzQ3ICAgICAgICAgICAwLjAKVGNwRXh0VENQRnJvbVplcm9XaW5k
b3dBZHYgICAgICAzNjEyOTQ5ICAgICAgICAgICAgMC4wClRjcEV4dFRDUFRvWmVyb1dpbmRvd0Fk
diAgICAgICAgMzYxMjk1MyAgICAgICAgICAgIDAuMApUY3BFeHRUQ1BXYW50WmVyb1dpbmRvd0Fk
diAgICAgIDAgICAgICAgICAgICAgICAgICAwLjAKVGNwRXh0VENQU3luUmV0cmFucyAgICAgICAg
ICAgICAxOTQ0NjYgICAgICAgICAgICAgMC4wClRjcEV4dFRDUE9yaWdEYXRhU2VudCAgICAgICAg
ICAgMTI2MTc5MjAyMSAgICAgICAgIDAuMApUY3BFeHRUQ1BIeXN0YXJ0VHJhaW5EZXRlY3QgICAg
IDQwMTQwICAgICAgICAgICAgICAwLjAKVGNwRXh0VENQSHlzdGFydFRyYWluQ3duZCAgICAgICA0
ODI4Nzg0ICAgICAgICAgICAgMC4wClRjcEV4dFRDUEh5c3RhcnREZWxheURldGVjdCAgICAgMTcg
ICAgICAgICAgICAgICAgIDAuMApUY3BFeHRUQ1BIeXN0YXJ0RGVsYXlDd25kICAgICAgIDg0ODkg
ICAgICAgICAgICAgICAwLjAKVGNwRXh0VENQQUNLU2tpcHBlZFN5blJlY3YgICAgICAwICAgICAg
ICAgICAgICAgICAgMC4wClRjcEV4dFRDUEFDS1NraXBwZWRQQVdTICAgICAgICAgMyAgICAgICAg
ICAgICAgICAgIDAuMApUY3BFeHRUQ1BBQ0tTa2lwcGVkU2VxICAgICAgICAgIDU4MCAgICAgICAg
ICAgICAgICAwLjAKVGNwRXh0VENQQUNLU2tpcHBlZEZpbldhaXQyICAgICAwICAgICAgICAgICAg
ICAgICAgMC4wClRjcEV4dFRDUEFDS1NraXBwZWRUaW1lV2FpdCAgICAgMCAgICAgICAgICAgICAg
ICAgIDAuMApUY3BFeHRUQ1BBQ0tTa2lwcGVkQ2hhbGxlbmdlICAgIDAgICAgICAgICAgICAgICAg
ICAwLjAKVGNwRXh0VENQV2luUHJvYmUgICAgICAgICAgICAgICAwICAgICAgICAgICAgICAgICAg
MC4wClRjcEV4dFRDUEtlZXBBbGl2ZSAgICAgICAgICAgICAgMjAyNDcyNSAgICAgICAgICAgIDAu
MApUY3BFeHRUQ1BNVFVQRmFpbCAgICAgICAgICAgICAgIDAgICAgICAgICAgICAgICAgICAwLjAK
VGNwRXh0VENQTVRVUFN1Y2Nlc3MgICAgICAgICAgICAwICAgICAgICAgICAgICAgICAgMC4wClRj
cEV4dFRDUERlbGl2ZXJlZCAgICAgICAgICAgICAgMTI2OTI2ODY4MiAgICAgICAgIDAuMApUY3BF
eHRUQ1BEZWxpdmVyZWRDRSAgICAgICAgICAgIDAgICAgICAgICAgICAgICAgICAwLjAKVGNwRXh0
VENQQWNrQ29tcHJlc3NlZCAgICAgICAgICAxMDI4MzA2ICAgICAgICAgICAgMC4wClRjcEV4dFRD
UFplcm9XaW5kb3dEcm9wICAgICAgICAgNDg1NDg5ICAgICAgICAgICAgIDAuMApUY3BFeHRUQ1BS
Y3ZRRHJvcCAgICAgICAgICAgICAgIDAgICAgICAgICAgICAgICAgICAwLjAKVGNwRXh0VENQV3F1
ZXVlVG9vQmlnICAgICAgICAgICAwICAgICAgICAgICAgICAgICAgMC4wClRjcEV4dFRDUEZhc3RP
cGVuUGFzc2l2ZUFsdEtleSAgMCAgICAgICAgICAgICAgICAgIDAuMApUY3BFeHRUY3BUaW1lb3V0
UmVoYXNoICAgICAgICAgIDE5NTM0NiAgICAgICAgICAgICAwLjAKVGNwRXh0VGNwRHVwbGljYXRl
RGF0YVJlaGFzaCAgICA1MyAgICAgICAgICAgICAgICAgMC4wClRjcEV4dFRDUERTQUNLUmVjdlNl
Z3MgICAgICAgICAgNzc1MzkgICAgICAgICAgICAgIDAuMApUY3BFeHRUQ1BEU0FDS0lnbm9yZWRE
dWJpb3VzICAgIDEyICAgICAgICAgICAgICAgICAwLjAKVGNwRXh0VENQTWlncmF0ZVJlcVN1Y2Nl
c3MgICAgICAwICAgICAgICAgICAgICAgICAgMC4wClRjcEV4dFRDUE1pZ3JhdGVSZXFGYWlsdXJl
ICAgICAgMCAgICAgICAgICAgICAgICAgIDAuMApUY3BFeHRUQ1BQTEJSZWhhc2ggICAgICAgICAg
ICAgIDAgICAgICAgICAgICAgICAgICAwLjAKSXBFeHRJbk5vUm91dGVzICAgICAgICAgICAgICAg
ICA0ICAgICAgICAgICAgICAgICAgMC4wCklwRXh0SW5UcnVuY2F0ZWRQa3RzICAgICAgICAgICAg
MCAgICAgICAgICAgICAgICAgIDAuMApJcEV4dEluTWNhc3RQa3RzICAgICAgICAgICAgICAgIDYg
ICAgICAgICAgICAgICAgICAwLjAKSXBFeHRPdXRNY2FzdFBrdHMgICAgICAgICAgICAgICAxNiAg
ICAgICAgICAgICAgICAgMC4wCklwRXh0SW5CY2FzdFBrdHMgICAgICAgICAgICAgICAgMCAgICAg
ICAgICAgICAgICAgIDAuMApJcEV4dE91dEJjYXN0UGt0cyAgICAgICAgICAgICAgIDAgICAgICAg
ICAgICAgICAgICAwLjAKSXBFeHRJbk9jdGV0cyAgICAgICAgICAgICAgICAgICAxMTU2NjU4NTY3
OTMwNTEgICAgMC4wCklwRXh0T3V0T2N0ZXRzICAgICAgICAgICAgICAgICAgMjA5OTE2MTg1MDAx
NzQgICAgIDAuMApJcEV4dEluTWNhc3RPY3RldHMgICAgICAgICAgICAgIDMwNiAgICAgICAgICAg
ICAgICAwLjAKSXBFeHRPdXRNY2FzdE9jdGV0cyAgICAgICAgICAgICA3MDYgICAgICAgICAgICAg
ICAgMC4wCklwRXh0SW5CY2FzdE9jdGV0cyAgICAgICAgICAgICAgMCAgICAgICAgICAgICAgICAg
IDAuMApJcEV4dE91dEJjYXN0T2N0ZXRzICAgICAgICAgICAgIDAgICAgICAgICAgICAgICAgICAw
LjAKSXBFeHRJbkNzdW1FcnJvcnMgICAgICAgICAgICAgICAwICAgICAgICAgICAgICAgICAgMC4w
CklwRXh0SW5Ob0VDVFBrdHMgICAgICAgICAgICAgICAgNDE3Nzg3MDYxODMgICAgICAgIDAuMApJ
cEV4dEluRUNUMVBrdHMgICAgICAgICAgICAgICAgIDAgICAgICAgICAgICAgICAgICAwLjAKSXBF
eHRJbkVDVDBQa3RzICAgICAgICAgICAgICAgICAyOTkgICAgICAgICAgICAgICAgMC4wCklwRXh0
SW5DRVBrdHMgICAgICAgICAgICAgICAgICAgMCAgICAgICAgICAgICAgICAgIDAuMApJcEV4dFJl
YXNtT3ZlcmxhcHMgICAgICAgICAgICAgIDAgICAgICAgICAgICAgICAgICAwLjAK
--000000000000a4399406357e7027--

