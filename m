Return-Path: <netdev+bounces-207023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 088DEB054CE
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 10:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 488FA169A2F
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 08:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71327274674;
	Tue, 15 Jul 2025 08:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nf7cVp/5"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96445273D82
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 08:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752567940; cv=none; b=I0ojShTnJPyQK5vwQyF5TWvtjb9fC5PC0JHl9GvD8jRMCOLNRCec/RVudBzkmn+pPgyP9hnr/443SR4ywCaTPaAKpQ3uJyw+sFy3g628MFhwUwAS+PHvjd88NiNpvfTpTTVJBd83JumQMIDPCR8pOoEA38x73ciiAtkS/bFBCUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752567940; c=relaxed/simple;
	bh=LMqVQPA8kERB/Y0IL3REKKo9mJLHie8xigKvyDSegbc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YsTC8wRyfXMj2TU6WuzebS3Jdmf78M4J6PZcoRqSKrphUHa++xy8r0sj67Ec9Xa7GYsCJh1Mlylud6LRf/5nPX2dEOflibSYsFhqL0x/9JOTMU23MUfI/xcnilFTBP+09cPe6fSJnwdua8cNwFcUBdQzHD2T7c2HtkFwLEQ5Ezs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nf7cVp/5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752567937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sKYfYL7fn5Doev8kENOTZ0t9E3TaB1QT1QecoUzYFAQ=;
	b=Nf7cVp/5BS0aRgFTnxDJb/zwGMtcGNDuTxhebF5gDtE5EpeAPBTAzu8RNs4zBa565Xzn9F
	eIfTgtgrVkpni9ct7G4CwADE+1wstRQfAdrBweH3wJFkVqUkc82bEhjSPR1TQPkKMjyWd7
	gXeToP542MD1AnNu4nXQxrZHhltf4aA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-lvOxts1XNGCY4tJyxXK8gg-1; Tue, 15 Jul 2025 04:25:35 -0400
X-MC-Unique: lvOxts1XNGCY4tJyxXK8gg-1
X-Mimecast-MFC-AGG-ID: lvOxts1XNGCY4tJyxXK8gg_1752567934
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a6d1394b07so3710389f8f.3
        for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 01:25:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752567934; x=1753172734;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sKYfYL7fn5Doev8kENOTZ0t9E3TaB1QT1QecoUzYFAQ=;
        b=KdrNsb9OyWEGI9j26BnBtcDl0H/yFXr9BzQhH9zbRRAK40QAkNeCyw3pHkDX3yYHZL
         mYBsPDhuUW1QbTbBGLpQs+70TvmB2rbo5ix80AZTn3Gaj5XjnPN+s0al5nOrbLUGQRgt
         swlLdftMrguRSvKR3lRPAsXJ3JYDPuJn02cLoX7227GazONE4n25mKlQEUTQ3xIv9EF3
         f57W+ojrDBk+vCvqg3neufb+/J8IlQ4RuZKQpXLxI+gBVxxdJo2AP2x1NY0CAjzv20UE
         ea8CqaMtLsYQSxud3MgWzseoStDorZWCrWigvZ77cHz66ClR+glmv3TFdIQvBk1obrD0
         aUdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXU/4yCle5Gl7UqwNF04esD0bhvbpsc6oL5v+NMpShlLhd5CVb0/FcUsQW0FeROVI64GlIYjcE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY/LV6gl7ZdciHFyG+me+XM9lbNh+44PO8BYbyj4IWrPzUxEju
	iCrRcUJx6iGKYiVp3PRprPE2h/PNm3TIUqeXo8R0NVtkDSmvp99MMqaF5xqEceDRqjzYzXflgtD
	SUpXPOUu2VjvQsku9BIJQIVw2BhrAEo/1QkFPWJIZwIpsuEm7uAStxfEkCQ==
X-Gm-Gg: ASbGncvsa+UcRcWrNVQBBou17+vldAy8xZ2Y2ip1Z0Vm1xEFBPbwpuQbmhdll1Cldq/
	739579dnYRnTfdJJYdaibr4UPrU0+4DMMNxXoRxk2VzGSg7lS5TnrVJkUhdMrUK3j+cAEzCNOg1
	QkDfGyPLnvG69wTaq+jRcvCoYTm6WBvNWzWxobTpZNlt+LAmecApggB80YyKpj6yotaG8vWowL7
	7uW7NJAAeI5YvU1Q5bj2XaqR5lNcSAE7qW4p132S2xNe6m2LsRYc4DnAsx3LdU+w8ogKR/O/j2G
	RQM1G1I3N5dvWDNoI+EQBwtXWxWPvu9gup7yvekpFvyM4fVHeJ0BMaCwPYq+/FIOdI6KsqZtZAw
	N4eChvH8fTRc=
X-Received: by 2002:a5d:64e8:0:b0:3b5:d726:f16c with SMTP id ffacd0b85a97d-3b60a1aafd3mr1185236f8f.47.1752567934328;
        Tue, 15 Jul 2025 01:25:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsRmxUXGKefUjgwsRimqamn1wkIxOpkaAwQ4akiy12qPHB0JLLB9f8hekOfnux9Wbd74izkg==
X-Received: by 2002:a5d:64e8:0:b0:3b5:d726:f16c with SMTP id ffacd0b85a97d-3b60a1aafd3mr1185206f8f.47.1752567933899;
        Tue, 15 Jul 2025 01:25:33 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e26daasm14818538f8f.91.2025.07.15.01.25.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 01:25:33 -0700 (PDT)
Message-ID: <a7a89aa2-7354-42c7-8219-99a3cafd3b33@redhat.com>
Date: Tue, 15 Jul 2025 10:25:31 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/8] tcp: receiver changes
To: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>,
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, "David S . Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>
References: <20250711114006.480026-1-edumazet@google.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250711114006.480026-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/11/25 1:39 PM, Eric Dumazet wrote:
> Before accepting an incoming packet:
> 
> - Make sure to not accept a packet beyond advertized RWIN.
>   If not, increment a new SNMP counter (LINUX_MIB_BEYOND_WINDOW)
> 
> - ooo packets should update rcv_mss and tp->scaling_ratio.
> 
> - Make sure to not accept packet beyond sk_rcvbuf limit.
> 
> This series includes three associated packetdrill tests.

I suspect this series is causing pktdrill failures for the
tcp_rcv_big_endseq.pkt test case:

# selftests: net/packetdrill: tcp_rcv_big_endseq.pkt
# TAP version 13
# 1..2
# tcp_rcv_big_endseq.pkt:41: error handling packet: timing error:
expected outbound packet at 1.347964 sec but happened at 1.307939 sec;
tolerance 0.014000 sec
# script packet:  1.347964 . 1:1(0) ack 54001 win 0
# actual packet:  1.307939 . 1:1(0) ack 54001 win 0
# not ok 1 ipv4
# tcp_rcv_big_endseq.pkt:41: error handling packet: timing error:
expected outbound packet at 1.354946 sec but happened at 1.314923 sec;
tolerance 0.014000 sec
# script packet:  1.354946 . 1:1(0) ack 54001 win 0
# actual packet:  1.314923 . 1:1(0) ack 54001 win 0
# not ok 2 ipv6
# # Totals: pass:0 fail:2 xfail:0 xpass:0 skip:0 error:0

the event is happening _before_ the expected time, I guess it's more a
functional issue than a timing one.

I also suspect this series is causing flakes in mptcp tests, i.e.:

# INFO: disconnect
# 63 ns1 MPTCP -> ns1 (10.0.1.1:20001      ) MPTCP     (duration
227ms) [ OK ]
# 64 ns1 MPTCP -> ns1 (10.0.1.1:20002      ) TCP       (duration
96ms) [ OK ]
# 65 ns1 TCP   -> ns1 (10.0.1.1:20003      ) MPTCP     copyfd_io_poll:
poll timed out (events: POLLIN 0, POLLOUT 4)
# copyfd_io_poll: poll timed out (events: POLLIN 1, POLLOUT 0)
# (duration 30318ms) [FAIL] client exit code 2, server 0
#
# netns ns1-VslcTV (listener) socket stat for 20003:
# Netid State      Recv-Q Send-Q Local Address:Port  Peer Address:Port

# tcp   FIN-WAIT-2 0      0           10.0.1.1:20003     10.0.1.1:60698
timer:(timewait,59sec,0) ino:0 sk:1012
#
# tcp   TIME-WAIT  0      0           10.0.1.1:20003     10.0.1.1:60696
timer:(timewait,29sec,0) ino:0 sk:1013
#
# TcpActiveOpens                  3                  0.0
# TcpPassiveOpens                 3                  0.0
# TcpInSegs                       1472               0.0
# TcpOutSegs                      1471               0.0
# TcpRetransSegs                  3                  0.0
# TcpExtPruneCalled               4                  0.0
# TcpExtRcvPruned                 3                  0.0
# TcpExtTW                        3                  0.0
# TcpExtBeyondWindow              7                  0.0
# TcpExtTCPHPHits                 34                 0.0
# TcpExtTCPPureAcks               386                0.0
# TcpExtTCPHPAcks                 33                 0.0
# TcpExtTCPSackRecovery           1                  0.0
# TcpExtTCPFastRetrans            1                  0.0
# TcpExtTCPLossProbes             2                  0.0
# TcpExtTCPLossProbeRecovery      1                  0.0
# TcpExtTCPRcvCollapsed           3                  0.0
# TcpExtTCPBacklogCoalesce        261                0.0
# TcpExtTCPSackShiftFallback      1                  0.0
# TcpExtTCPRcvCoalesce            500                0.0
# TcpExtTCPOFOQueue               1                  0.0
# TcpExtTCPFromZeroWindowAdv      60                 0.0
# TcpExtTCPToZeroWindowAdv        58                 0.0
# TcpExtTCPWantZeroWindowAdv      296                0.0
# TcpExtTCPOrigDataSent           1038               0.0
# TcpExtTCPHystartTrainDetect     1                  0.0
# TcpExtTCPHystartTrainCwnd       16                 0.0
# TcpExtTCPACKSkippedSeq          1                  0.0
# TcpExtTCPWinProbe               7                  0.0
# TcpExtTCPDelivered              1041               0.0
# TcpExtTCPRcvQDrop               2                  0.0
#
# netns ns1-VslcTV (connector) socket stat for 20003:
# Failed to find cgroup2 mount
# Failed to find cgroup2 mount
# Netid State     Recv-Q Send-Q  Local Address:Port  Peer Address:Port

# tcp   TIME-WAIT 0      0            10.0.1.1:60684     10.0.1.1:20003
timer:(timewait,29sec,0) ino:0 sk:11
#
# tcp   LAST-ACK  0      1735147      10.0.1.1:60698     10.0.1.1:20003
timer:(persist,22sec,0) ino:0 sk:12 cgroup:unreachable:1 ---
#  skmem:(r0,rb361100,t0,tb2626560,f2838,w1758442,o0,bl0,d61) ts sack
cubic wscale:7,7 rto:201 backoff:7 rtt:0.12/0.215 ato:40 mss:65483
pmtu:65535 rcvmss:65483 advmss:65483 cwnd:7 ssthresh:7
bytes_sent:1738187 bytes_retrans:65461 bytes_acked:1672727
bytes_received:7659224 segs_out:180 segs_in:243 data_segs_out:103
data_segs_in:221 send 30558733333bps lastsnd:30125 lastrcv:30322
lastack:3693 pacing_rate 36480477512bps delivery_rate 196449000000bps
delivered:103 app_limited busy:30351ms rwnd_limited:30350ms(100.0%)
retrans:0/1 rcv_rtt:0.005 rcv_space:289974 rcv_ssthresh:324480
notsent:1735147 minrtt:0.001 rcv_wnd:324480

@Matttbe: can you reproduce the flakes locally? if so, does reverting
that series stop them? (not that I'm planning a revert, just to validate
my guess).

Thanks,

Paolo


