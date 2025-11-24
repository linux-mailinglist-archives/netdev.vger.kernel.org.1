Return-Path: <netdev+bounces-241222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E404C81945
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 17:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E68374E6E37
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 16:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5073168E0;
	Mon, 24 Nov 2025 16:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J052Fxy0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F13B31AF3C
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 16:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764001775; cv=none; b=C3SMySkA2J9vP3B3IdF/bSda/+AM4XRYuFq94upaB5J/Db80XPpLxGwcLBqufRk8uSVwZKYm99RQ2CT7JmBo6Xiu+ZfZzeojxEx/XgxjtHhNPWcVsAnsiR6DNVyIDo2MWdRGtalgRRElb98Xt+gVB8KQu6snNjVHeq6Nxd4oY9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764001775; c=relaxed/simple;
	bh=F/p/HJ0/jHiLQSXLO3hCOO+zAtgb4lO8dstTsLDVbN8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=HD4z5tHYvSigb1Z/YP/Ay9xv+JlJtjzesw7/W3HwngRsmcvBo3cXlR3M9oK+hMgvW3JBuSGg2/ikoCAPgYxgf30l/VJk+kjFt1lbiRoJBDlRix72UMSCzCybTFgWlLG9D39RfOr0AGAvxjri3o2k/lKdfluMKV/lok14JUOuzCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J052Fxy0; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-78a835353e4so40477487b3.2
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 08:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764001772; x=1764606572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EXs6TXJv7ekh4mmD2BOASV1Zx3Fsj+Ymhs6dgEcpKxI=;
        b=J052Fxy0+bhrCa5oNmy6OFgLP11AdmgaKX0q5AjjZnXNy9SW5B33VqGn/VOJO23F/Y
         i8f46+JD0uPlq/tyeUU6WR7lgHVubRuu4qMFPmi1lClnD0Y61SgCXtjCZfPjgQiaio5O
         /ad/GrGQUBwCQTdNIWWmoYlCUUOp0Lq17E6oU2X9Mf+85v25/09fH2bEyon6BNLcztgI
         wa2LOTMyp3lPVmNSu6jBYmMeULNkB30j4M0JrdP0NW7CDpdFx2RzrVPQi13y4T9CoEuP
         K2Y3NNJr05hm1Aw0E0MpPqZbLz0Ci/BEc/NQuNA4LhmmRB3ivBMrp3gT99zIe79vzz5W
         CXGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764001772; x=1764606572;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EXs6TXJv7ekh4mmD2BOASV1Zx3Fsj+Ymhs6dgEcpKxI=;
        b=wM2GA2V44ZO7ZF+drDaj/k7qAnCzBbopTcHsjahY0VCliqDkHVzoVjteb4AoulCuwH
         9m0PUCEuyyK/BSzAZxWIrqFgJbRfk3/JB/XtP42RCdT6uDg/JWcLZ+vs/DoViTdDlhCk
         1bgiyHPLY63fGTtcBQunc+gJdCkYnCuIvDSI3i/2lfjb06rkQJ5dGlnOr7CgTUGalPWw
         auaLtp4KdCxofZR+6vUZA8GHUmb9xUvTRSRP1dCjMmw8hQLJx1jBHux4Ko5U2INUXefl
         w5fn1nGLe1jCeg6QLjJJwbPSbJwqt25jLWk9xWwNGkn7kVs8YpUOYL00i46h7H9UciDA
         HYHw==
X-Gm-Message-State: AOJu0YyuuLt18KnAVnnUsEl1oYX/21cYASwtwKnzO5X8FB2aqOaTc2HB
	8gd3O75QgTZz4FJ0da+xZ0hK0o1GNzs2M7IbX28eFwOTyKFKSgR4VRzb
X-Gm-Gg: ASbGncu+L3D0H5dJD2jUG7RL2as8rURLJanDxY0L4FP4YBOpnXAjTqsieIVApuY1UdL
	0IyIj6WDSf+MgKhKgVJngS3fnKqfHfG/4O/dt2RlOiUAN1TfnfDPOmHrCR//fCVo9+xwKW0etCX
	n4t2kYpuGBpSp7j53qbitrgQA5jYJCSgC3S6I27nMwyQnr//HwPn9LPVmovYzq4hNFPMqKpgF25
	uAer+F9ZOU2DGsjro7ov+4HzBCirlz/4UlWZe235//v0BFO8aZheWrZXnaqf8MMb2YROTXZmfy7
	3pxoyQ5l6gDZuvuk6q2AsKHeCVnS18I7UO0PtZ7xiLbhgACpuWNVqLG2C9rMqEq5bOalewMCqEj
	+5QCa1uaH3pQ18E6rVz+wZx+d1XJOdzr7ogPJAg1DvzpTiS83zBraJehL1zVS+8m2Fj+HxIoxeK
	hHtPOctIj3tHvRXTFVZgkzvgv0U6S4gWbLkpN7678/ExK/iTIq7zzqzniwfPl/VNOSQXeR4JDiF
	jK//w==
X-Google-Smtp-Source: AGHT+IGw2zzWJixsO2IN3R+1XP+R3jMDdKaoUbOzVFqNI0EM2QPF0TsNm0BHrHdqMhYl4bERvp6RSQ==
X-Received: by 2002:a05:690e:128e:b0:633:a260:14a1 with SMTP id 956f58d0204a3-64302a3e9a3mr7575612d50.18.1764001772598;
        Mon, 24 Nov 2025 08:29:32 -0800 (PST)
Received: from gmail.com (116.235.236.35.bc.googleusercontent.com. [35.236.235.116])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-642f707a9b9sm5114267d50.6.2025.11.24.08.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 08:29:31 -0800 (PST)
Date: Mon, 24 Nov 2025 11:29:31 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemb@google.com>
Cc: netdev@vger.kernel.org
Message-ID: <willemdebruijn.kernel.1fe4306a89d08@gmail.com>
In-Reply-To: <20251124071831.4cbbf412@kernel.org>
References: <20251124071831.4cbbf412@kernel.org>
Subject: Re: [TEST] tcp_zerocopy_maxfrags.pkt fails
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> Hi Willem!
> 
> I migrated netdev CI to our own infra now, and the slightly faster,
> Fedora-based system is failing tcp_zerocopy_maxfrags.pkt:
> 
> # tcp_zerocopy_maxfrags.pkt:56: error handling packet: incorrect outbound data payload
> # script packet:  1.000237 P. 36:37(1) ack 1 
> # actual packet:  1.000235 P. 36:37(1) ack 1 win 1050 
> # not ok 1 ipv4
> # tcp_zerocopy_maxfrags.pkt:56: error handling packet: incorrect outbound data payload
> # script packet:  1.000209 P. 36:37(1) ack 1 
> # actual packet:  1.000208 P. 36:37(1) ack 1 win 1050 
> # not ok 2 ipv6
> # # Totals: pass:0 fail:2 xfail:0 xpass:0 skip:0 error:0
> 
> https://netdev-ctrl.bots.linux.dev/logs/vmksft/packetdrill/results/399942/13-tcp-zerocopy-maxfrags-pkt/stdout
> 
> This happens on both debug and non-debug kernel (tho on the former 
> the failure is masked due to MACHINE_SLOW).

That's an odd error.

The test send an msg_iov of 18 1 byte fragments. And verifies that
only 17 fit in one packet, followed by a single 1 byte packet. The
test does not explicitly initialize payload, but trusts packetdrill
to handle that. Relevant snippet below.

Packetdrill complains about payload contents. That error is only
generated by the below check in run_packet.c. Pretty straightforward.

Packetdrill agrees that the packet is one byte long. The win argument
is optional on outgoing packets, not relevant to the failure.

So somehow the data in that frag got overwritten in the short window
between when it was injected into the kernel and when it was observed?
Seems so unlikely.

Sorry, I'm a bit at a loss at least initially as to the cause.

----

   // send a zerocopy iov of 18 elements:
   +1 sendmsg(4, {msg_name(...)=...,
                  msg_iov(18)=[{..., 1}, {..., 1}, {..., 1}, {..., 1},
                               {..., 1}, {..., 1}, {..., 1}, {..., 1},
                               {..., 1}, {..., 1}, {..., 1}, {..., 1},
                               {..., 1}, {..., 1}, {..., 1}, {..., 1},
                               {..., 1}, {..., 1}],
                  msg_flags=0}, MSG_ZEROCOPY) = 18

   // verify that it is split in one skb of 17 frags + 1 of 1 frag
   // verify that both have the PSH bit set
   +0 > P. 19:36(17) ack 1
   +0 < . 1:1(0) ack 36 win 257

   +0 > P. 36:37(1) ack 1
   +0 < . 1:1(0) ack 37 win 257

----

/* Verify TCP/UDP payload matches expected value. */
static int verify_outbound_live_payload(
        struct packet *actual_packet,
        struct packet *script_packet, char **error)
{
        /* Diff the TCP/UDP data payloads. We've already implicitly
         * checked their length by checking the IP and TCP/UDP headers.
         */
        assert(packet_payload_len(actual_packet) ==
               packet_payload_len(script_packet));
        if (memcmp(packet_payload(script_packet),
                   packet_payload(actual_packet),
                   packet_payload_len(script_packet)) != 0) {
                asprintf(error, "incorrect outbound data payload");
                return STATUS_ERR;
        }
        return STATUS_OK;
}


