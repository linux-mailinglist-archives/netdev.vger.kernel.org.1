Return-Path: <netdev+bounces-142647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0275D9BFD4C
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 05:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7EE1283748
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 04:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4A4192590;
	Thu,  7 Nov 2024 04:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="liv+wolc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144BC18C33B
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 04:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730952924; cv=none; b=XRctXvvD5Pr8Z/mh88iJ5QmHub3dOq8pdf1t9l0kHLFwnmJmfO48cyNPrsHi8Kz84cezXBeq6Bd4fka23ACfPXyBKpcE4C8KEdXwtsOqg66saz2eLiGJJ/UaWUldw1gRO3MLTsmr/8xIMv7YKzRkgQjZyAsC/cWMEXeX5onpfMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730952924; c=relaxed/simple;
	bh=kEbY6Oa2t1h75UHFBI4dd6DEtOTYFjk/3H7ZMOB3618=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E1novmB24pm02NFVUvb5xE5P1fKKqaxKN6L1Ge8YlRXcpl6D50cjLgDs3f6atJYuRlviiDl4pnC6raFrPs27FHONX0v+wfJqmQTGiWlJWnm7doEpSq5HAfMfNKkL/Mjnvp3p0rfwfKlzw1jOSDYlubVSaX2kujfAQkmlme6IBCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=liv+wolc; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1730952922; x=1762488922;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=APYM+0ztZdAy6qQFNWCogrAukLFHKnrgZV9RKbvlGh0=;
  b=liv+wolcfdQwe3fn8Wfm2kNPC/q5imVmg2Q7v/tsZLG7xHNe1Hp/+hRY
   of1QXSb0QA3mgnsOGZCbUWD46uJCyXP36DbYSRa7KAp5JIl9/oI9plUZK
   dZyb7ZedBxJ8YhjcyjVHGAU/1QIXsr7s5uytx+dOFrAtfnr9xXdNmW0XC
   I=;
X-IronPort-AV: E=Sophos;i="6.11,264,1725321600"; 
   d="scan'208";a="467817067"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 04:15:14 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:44396]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.26.115:2525] with esmtp (Farcaster)
 id 8238c843-fc52-4749-b4a8-2f2f366982c1; Thu, 7 Nov 2024 04:15:14 +0000 (UTC)
X-Farcaster-Flow-ID: 8238c843-fc52-4749-b4a8-2f2f366982c1
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 7 Nov 2024 04:15:12 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.101.27) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Thu, 7 Nov 2024 04:15:09 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kerneljasonxing@gmail.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<horms@kernel.org>, <kernelxing@tencent.com>, <kuba@kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <kuniyu@amazon.com>
Subject: Re: [PATCH net-next] tcp: avoid RST in 3-way shakehands due to failure in tcp_timewait_state_process
Date: Wed, 6 Nov 2024 20:15:06 -0800
Message-ID: <20241107041506.81695-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <CAL+tcoB9a7eKzU9sz8AaY0sqeKn9fkK9ejDJkfh9EpdcG17k-w@mail.gmail.com>
References: <CAL+tcoB9a7eKzU9sz8AaY0sqeKn9fkK9ejDJkfh9EpdcG17k-w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWA003.ant.amazon.com (10.13.139.105) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 7 Nov 2024 11:16:04 +0800
> > Here is how things happen in production:
> > Time        Client(A)        Server(B)
> > 0s          SYN-->
> > ...
> > 132s                         <-- FIN
> > ...
> > 169s        FIN-->
> > 169s                         <-- ACK
> > 169s        SYN-->
> > 169s                         <-- ACK
> 
> I noticed the above ACK doesn't adhere to RFC 6191. It says:
> "If the previous incarnation of the connection used Timestamps, then:
>      if ...
>      ...
>      * Otherwise, silently drop the incoming SYN segment, thus leaving
>          the previous incarnation of the connection in the TIME-WAIT
>          state.
> "
> But the timewait socket sends an ACK because of this code snippet:
> tcp_timewait_state_process()
>     -> // the checks of SYN packet failed.
>     -> if (!th->rst) {
>         -> return TCP_TW_ACK; // this line can be traced back to 2005

This is a challenge ACK following RFC 5961.

If SYN is returned here, the client may lose the chance to RST the
previous connection in TIME_WAIT.

https://www.rfc-editor.org/rfc/rfc9293.html#section-3.10.7.4-2.4.1
---8<---
      -  TIME-WAIT STATE

         o  If the SYN bit is set in these synchronized states, it may
            be either a legitimate new connection attempt (e.g., in the
            case of TIME-WAIT), an error where the connection should be
            reset, or the result of an attack attempt, as described in
            RFC 5961 [9].  For the TIME-WAIT state, new connections can
            be accepted if the Timestamp Option is used and meets
            expectations (per [40]).  For all other cases, RFC 5961
            provides a mitigation with applicability to some situations,
            though there are also alternatives that offer cryptographic
            protection (see Section 7).  RFC 5961 recommends that in
            these synchronized states, if the SYN bit is set,
            irrespective of the sequence number, TCP endpoints MUST send
            a "challenge ACK" to the remote peer:

            <SEQ=SND.NXT><ACK=RCV.NXT><CTL=ACK>
---8<---

https://datatracker.ietf.org/doc/html/rfc5961#section-4
---8<---
   1) If the SYN bit is set, irrespective of the sequence number, TCP
      MUST send an ACK (also referred to as challenge ACK) to the remote
      peer:

      <SEQ=SND.NXT><ACK=RCV.NXT><CTL=ACK>

      After sending the acknowledgment, TCP MUST drop the unacceptable
      segment and stop processing further.
---8<---

