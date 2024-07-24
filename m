Return-Path: <netdev+bounces-112732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D47B893AE09
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 10:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03E0B1C20272
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 08:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FAF374BED;
	Wed, 24 Jul 2024 08:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v8Yhf6Bb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MzMhGLiu"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851921C2AD;
	Wed, 24 Jul 2024 08:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721810903; cv=none; b=Up7M4BgCXsq1u4oPtSVHujZHe/vSXGsRLgTW/Yb/bbBAM1rCRy6vDvI/jFYwxo0VC1fF0zwppTANs2mviWAtPdiHc7OdRhlx5cnfkPSANQv4aZ1v/1XzVwbo2kuFPAPhM+VhW0BmIv3tYlapVEj1GYObO2vxLN0qrbWc2wwiZQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721810903; c=relaxed/simple;
	bh=giZ1dmbuQjDzsjiaqIcO7ZDY5ctThoN5p/C7jVFH8w0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eWzPC35MiDJrRCYrpmmsxfDTCVsb5jFDNgB9OCkzXdT1VetJ4rF3/pXzp4kGHDuXLd4cEu5thCB+V45FOqvbj6Cx96tE/Yik1M6qUsyZ+1RbZ21s0RSbxiEN45b+HELzmVGDhEEISlhpc0DqSZ10Y6mQ7CZ79g9zsihGElegMt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v8Yhf6Bb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MzMhGLiu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721810894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a09RrNU1F+fVmwep1n2NrhCMuBabpF9UyYl4Vp6fByY=;
	b=v8Yhf6BbxoSh1ZjTczM5EGIflRsKSxgwWFHStE+z7YqtX5kq2kgYov8WU2Jrs4DPvIipOy
	egYv88enTN3WG/dRtqG36EVyVf6AfhZOsTolAaRJYOvt9Y5ZNVE1Y+pcNh3GPOjTVw1Yrb
	NDG70NVLkeBxLBYQeivmOyWwJPQOYgU09+flqV3/OLpvIVvhktEJDCy6RQYZiqQMO2qXMp
	JDmDJbv3u/i+50vW5gPbw76c6rkFMgkhbyUxrOx8/nZUE24wXEXnhV6ZSMm7cK8JplJZCV
	+bM2f/DaPrT41N8n890asf9DnmCqcwP2XnWqbi4/mateqAmZYZaln7ehnbyFVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721810894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a09RrNU1F+fVmwep1n2NrhCMuBabpF9UyYl4Vp6fByY=;
	b=MzMhGLiu5kHdsIDeziOtvYQmhMNhh4/bGzAClUoZM+gdm0W/e4K+OEoN/c0VBQhCuYVrkQ
	0irI2p8K7jaAH4Dg==
To: Rodrigo Cataldo via B4 Relay
 <devnull+rodrigo.cadore.l-acoustics.com@kernel.org>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, Vinicius
 Costa Gomes <vinicius.gomes@intel.com>, "Christopher S. Hall"
 <christopher.s.hall@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Rodrigo Cataldo
 <rodrigo.cadore@l-acoustics.com>
Subject: Re: [PATCH iwl-net] igc: Ensure PTM request is completed before
 timeout has started
In-Reply-To: <20240708-igc-flush-ptm-request-before-timeout-6-10-v1-1-70e5ebec9efe@l-acoustics.com>
References: <20240708-igc-flush-ptm-request-before-timeout-6-10-v1-1-70e5ebec9efe@l-acoustics.com>
Date: Wed, 24 Jul 2024 10:48:12 +0200
Message-ID: <874j8fjhv7.fsf@kurt.kurt.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

On Mon Jul 08 2024, Rodrigo Cataldo via B4 Relay wrote:
> From: Rodrigo Cataldo <rodrigo.cadore@l-acoustics.com>
>
> When a PTM is requested via wr32(IGC_PTM_STAT), the operation may only
> be completed by the next read operation (flush). Unfortunately, the next
> read operation in the PTM request loop happens after we have already
> started evaluating the response timeout.
>
> Thus, the following behavior has been observed::
>
>   phc2sys-1655  [010]   103.233752: funcgraph_entry:                    |  igc_ptp_getcrosststamp() {
>   phc2sys-1655  [010]   103.233754: funcgraph_entry:                    |    igc_phc_get_syncdevice_time() {
>   phc2sys-1655  [010]   103.233755: funcgraph_entry:                    |      igc_rd32() {
>   phc2sys-1655  [010]   103.233931: preempt_disable: caller=irq_enter_rcu+0x14 parent=irq_enter_rcu+0x14
>   phc2sys-1655  [010]   103.233932: local_timer_entry: vector=236
>   phc2sys-1655  [010]   103.233932: hrtimer_cancel: hrtimer=0xffff8edeef526118
>   phc2sys-1655  [010]   103.233933: hrtimer_expire_entry: hrtimer=0xffff8edeef526118 now=103200127876 function=tick_nohz_handler/0x0
>
>   ... tick handler ...
>
>   phc2sys-1655  [010]   103.233971: funcgraph_exit:       !  215.559 us |      }
>   phc2sys-1655  [010]   103.233972: funcgraph_entry:                    |      igc_rd32() {
>   phc2sys-1655  [010]   103.234135: funcgraph_exit:       !  164.370 us |      }
>   phc2sys-1655  [010]   103.234136: funcgraph_entry:         1.942 us   |      igc_rd32();
>   phc2sys-1655  [010]   103.234147: console:              igc 0000:03:00.0 enp3s0: Timeout reading IGC_PTM_STAT register
>
> Based on the (simplified) code::
>
> 	ctrl = rd32(IGC_PTM_CTRL);
>         /* simplified: multiple writes here */
> 	wr32(IGC_PTM_STAT, IGC_PTM_STAT_VALID);
>
> 	err = readx_poll_timeout(rd32, IGC_PTM_STAT, stat,
> 				 stat, IGC_PTM_STAT_SLEEP,
> 				 IGC_PTM_STAT_TIMEOUT);
> 	if (err < 0) {
> 		netdev_err(adapter->netdev, "Timeout reading IGC_PTM_STAT register\n");
> 		return err;
> 	}
>
> Where readx_poll_timeout() starts the timeout evaluation before calling
> the rd32() parameter (rd32() is a macro for igc_rd32()).
>
> In the trace shown, the read operation of readx_poll_timeout() (second
> igc_rd32()) took so long that the timeout (IGC_PTM_STAT_VALID) has expired
> and no sleep has been performed.
>
> With this patch, a write flush is added (which is an additional
> igc_rd32() in practice) that can wait for the write before the timeout
> is evaluated::
>
>   phc2sys-1615  [010]    74.517954: funcgraph_entry:                    |  igc_ptp_getcrosststamp() {
>   phc2sys-1615  [010]    74.517956: funcgraph_entry:                    |    igc_phc_get_syncdevicetime() {
>   phc2sys-1615  [010]    74.517957: funcgraph_entry:                    |      igc_rd32() {
>   phc2sys-1615  [010]    74.518127: preempt_disable: caller=irq_enter_rcu+0x14 parent=irq_enter_rcu+0x14
>   phc2sys-1615  [010]    74.518128: local_timer_entry: vector=236
>   phc2sys-1615  [010]    74.518128: hrtimer_cancel: hrtimer=0xffff96466f526118
>   phc2sys-1615  [010]    74.518128: hrtimer_expire_entry: hrtimer=0xffff96466f526118 now=74484007229 function=tick_nohz_handler/0x0
>
>   ... tick handler ...
>
>   phc2sys-1615  [010]    74.518180: funcgraph_exit:       !  222.282 us |      }
>   phc2sys-1615  [010]    74.518181: funcgraph_entry:                    |      igc_rd32() {
>   phc2sys-1615  [010]    74.518349: funcgraph_exit:       !  168.160 us |      }
>   phc2sys-1615  [010]    74.518349: funcgraph_entry:         1.970 us   |      igc_rd32();
>   phc2sys-1615  [010]    74.518352: hrtimer_init: hrtimer=0xffffa6f9413a3940 clockid=CLOCK_MONOTONIC mode=0x0
>   phc2sys-1615  [010]    74.518352: preempt_disable: caller=_raw_spin_lock_irqsave+0x28 parent=hrtimer_start_range_ns+0x56
>   phc2sys-1615  [010]    74.518353: hrtimer_start: hrtimer=0xffffa6f9413a3940 function=hrtimer_wakeup/0x0 expires=74484232878 softexpires=74484231878
>
>   .. hrtimer setup and return ...
>
>   kworker/10:1-242   [010]    74.518382: sched_switch: kworker/10:1:242 [120] W ==> phc2sys:1615 [120]
>   phc2sys-1615  [010]    74.518383: preempt_enable: caller=schedule+0x36 parent=schedule+0x36
>   phc2sys-1615  [010]    74.518384: funcgraph_entry:      !  100.088 us |      igc_rd32();
>   phc2sys-1615  [010]    74.518484: funcgraph_entry:         1.958 us   |      igc_rd32();
>   phc2sys-1615  [010]    74.518488: funcgraph_entry:         2.019 us   |      igc_rd32();
>   phc2sys-1615  [010]    74.518490: funcgraph_entry:         1.956 us   |      igc_rd32();
>   phc2sys-1615  [010]    74.518492: funcgraph_entry:         1.980 us   |      igc_rd32();
>   phc2sys-1615  [010]    74.518494: funcgraph_exit:       !  539.386 us |    }
>
> Now the sleep is called as expected, and the operation succeeds.
> Therefore, regardless of how long it will take for the write to be
> completed, we will poll+sleep at least for the time specified in
> IGC_PTM_STAT_TIMEOUT.
>
> Fixes: a90ec8483732 ("igc: Add support for PTP getcrosststamp()")
> Signed-off-by: Rodrigo Cataldo <rodrigo.cadore@l-acoustics.com>

Thanks for sending this upstream.

Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJSBAEBCgA8FiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmagv8weHGt1cnQua2Fu
emVuYmFjaEBsaW51dHJvbml4LmRlAAoJEMGT0fKqRnOCuLUP/ib+0Vgkt4GIrTNy
Gh9EkFw+VPjRPEnxPMIHRWl9XJnHJfVbOZp6u05cBpXE5M32SicSPEhO2ZZzBrUp
NRlIlKhrlTLKa3m57duu2o0PY1572Ay0LyfiEF06joZUqX97kST26QlRYjdqVgzF
+PeQ9DTZ3wpltPMzmvXE6g8T02xumCbg6CgohmYjnVeCFG94ADr26+WPSoP0lX4o
9bCJg7J/5nMfUmORzQ6dvLmlkURk4n18wguSab0hJnMAvbbCxZIlch5sGicUxbka
AqcwWLz/CtpdoJ6VA5FR1aX0D2h597qDR6ULvsB8NjH942zRNr8akq00qS6tkGNp
WFYlu58gQhDr6Zr7yWYWUXiI/4/1OTko/pesir7knzODd0bVCbf7PJIf1vkim84s
00nfwkRBr/DBemxCbiOyV3F33sdntUe2Sx3iX8LqAwO8vcesltvED/xd18Ch6nj7
ZucOsd/2bMqD1Key/8lzFdiMebLJV/ywoWg9dde7tsatdeDokzX3QhJZcWXktkah
qcHremtXKQ7vzYn6yf3EV+oNBZlTULRoDar5MJWF6/EGnwl+2Y6xbfGEQh3t5uMB
kPpXNE9VXOop4N5fLhtQ1HE1gq/doCo1rtp99Uo5iz3VppHNWHi1za8E4GFmXvb3
kfWSE0TO7Z60rN2ANn9RS4QPj+hG
=hICY
-----END PGP SIGNATURE-----
--=-=-=--

