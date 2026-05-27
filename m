Return-Path: <netdev+bounces-292376-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kNT7HFYdF2rw5AcAu9opvQ
	(envelope-from <netdev+bounces-292376-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 18:35:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B68E05E7D57
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 18:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B4273020D44
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 16:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF38438FED;
	Wed, 27 May 2026 16:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g89DOoBA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2946942EEB6
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 16:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779899351; cv=none; b=HmUsm4tzOxWpJM3ID9J2Nyv+kIFTrsV3CZQQ+tOQbiaVoLt9ps/16V/OQt1IW2tikRYOHFHabKlFSLol/aral+Z/GdB0+WGIRxvRgQo01+h0rDq1w8kbT3HiTo6HftuGnOhy+TnpY7ds4AuJTdfyYEVH5+j3zQ7eYRkqquphGHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779899351; c=relaxed/simple;
	bh=MARgWSB2JRyHiWTRwBhBMqTryJPPS2jchIS4w1LrmWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f5LasXmbBTgCa10E3nSZN2kpunrGBD7o2Rm6idcOVyWe10ZxSEXyxqCUfgENLU6DvMhGt4ns7CtNqcQpfs8j9m1Dm7tdATxz7uU75NiTorgS3/KeZf9NseqJTvA92o8agDVd89Sh8+Ru63jDNs8NzeNtgpuaAzH7s+GgTgxjRo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g89DOoBA; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4891e86fabeso24857965e9.1
        for <netdev@vger.kernel.org>; Wed, 27 May 2026 09:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779899344; x=1780504144; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lp8EUEG6k+uQx75sbagyQs35jMaojHEjO5L3ntgLVNA=;
        b=g89DOoBAuI83xqPWszuqhCTddZx0ONETKVoZcKFdcASpTkVpc7A18DmvjXbkukKjp3
         jCzHh6oa0O2O60ft1uy4iEi3QrFypdTqA3bXE63RDDuojo2QkvpTLC4QvG0P5OSzsocv
         fEU4i5WODBfJsI4QSgvSCYAGpHQwvBou62wMJHBx4Ogc0QB+VeM8xYq14VPYB6aroWft
         GIJ3NGD/4re4dH4cAL6MU74xJCB/GqsPxFIqXwUz3hgODjcwYrWdL+rCF/7XwdcTaNc6
         qcAMLG3NeHvmXmJQ2AkRTxH83svDmpqoDBjLEPvCKlLfJwHNtyKbeO75s5nLFLuBMXVh
         MUhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779899344; x=1780504144;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lp8EUEG6k+uQx75sbagyQs35jMaojHEjO5L3ntgLVNA=;
        b=LBg8SwYUF7oG5OVFI+CBCvZAVaOdm1kiAuQ9Ydg1q77j7XoIkPUxrbq7u4j45HWT8+
         gnSiw6vF83znMcvNg1KS9JeFTMvpBWjyjIxqHgWqOAqYE5t3//EYoYqFzb2ih8A3kGTS
         4OFCGnjZK9x6JnvmgBcx9QEePb6nErvLSTqupoZmFcWzigVs3aXgi5Vx2I2MRiFR8NFJ
         pTiN05tBWMgoqzfhPtRJCbYNG+kHX55wT1IXNqbNZOK50zAF2U52r1wum8Kr89jTS6P4
         Lz42g1Zgbgr0gNieTM2x4NEkJ6By/PH9+3oDKsfTICDvcxG2SsdaxdN3ja3QlpHbZBYi
         hyqA==
X-Forwarded-Encrypted: i=1; AFNElJ/DNOmSUh4aO1hh54XfXeW2obJ5XlsqQXG1pmT33FYap6jBzY4zqqSXhNCa48AVm9eATLQfOC8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywptv2Qc5mCJrufTfr7OK1XnTX2/buBSYADWo9/Wu/ZzVGN/wXP
	xPi+Db1hHMogb/2Br0cEvpKWveMqAgQ/9gp+D3wCdPxmCSgnHAkMBsXW/oVxsEZWLw==
X-Gm-Gg: Acq92OH/lqL/NlGtHxC7VaFSAhP7mZhu4FLiWyVz5DoGEDsj20xHirIUmNbN3Tna1In
	6s+6YooeRdAUIrri5LQBkcCrofJ+o0ZGd4X6utEpqG/CAc7ExQyTwJ0LErJK7dCFyRDq2K0rCbM
	+4WpT6U+KEKUIbS3yg7EczLtlJkfEQ57fUbCHN6HskdroklYyjU+yFhpGj6sYCaAnue+rqmy97K
	NvxvjdpyLKILUSbu3DDYiOtuS0jW2AD+prAw6L2Zcsa7EoObGQkJgpsBzvK+fKtnnB13GEx6Mvr
	dj2d/ViF0cy80A2o2ColYx+hVLLV1rDHlVsyWwt3U4TCZtQqha64PR8wT2cgdJDQpm2kcWu3PSx
	oY72XiZGkK9hsZgzf1iSmWVy7b7kk1wMdO3r6NmL0ex/iHv1miNK5sn85VtCU6aUMqY3v6bZ6DQ
	2lr0zwI7G08+wHmZ6N/LZRP8YWoCQIIpFtc+jBwlhR7QCaqTE5CKU6tfr5e48MHPY3Lk20pO/nx
	xxoEQ==
X-Received: by 2002:a05:600c:45ce:b0:490:5cd8:d213 with SMTP id 5b1f17b1804b1-4905cd8d33emr244688485e9.15.1779899343733;
        Wed, 27 May 2026 09:29:03 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4904561a160sm466125765e9.9.2026.05.27.09.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 09:29:03 -0700 (PDT)
Date: Wed, 27 May 2026 17:28:59 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Miroslav Lichvar <mlichvar@redhat.com>,
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	thomas.weissschuh@linutronix.de,
	Arthur Kiyanovski <akiyano@amazon.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>, kvmarm@lists.linux.dev,
	Rodolfo Giometti <giometti@enneenne.com>,
	Oliver Upton <oupton@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
	Takashi Iwai <tiwai@suse.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Peter Hilber <peter.hilber@oss.qualcomm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	virtualization@lists.linux.dev, linux-wireless@vger.kernel.org,
	linux-sound@vger.kernel.org
Subject: Re: [patch 05/24] KVM: arm64: Use ktime_get_snapshot_id() to
 retrieve CLOCK_BOOTTIME
Message-ID: <ahcby8senHsmpOBm@google.com>
References: <20260526165826.392227559@kernel.org>
 <20260526171223.070087856@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526171223.070087856@kernel.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,infradead.org,redhat.com,google.com,kernel.org,linutronix.de,amazon.com,linux.dev,lists.linux.dev,enneenne.com,gmail.com,suse.com,intel.com,nvidia.com,oss.qualcomm.com];
	TAGGED_FROM(0.00)[bounces-292376-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_TWELVE(0.00)[28];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vdonnefort@google.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email]
X-Rspamd-Queue-Id: B68E05E7D57
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 07:13:53PM +0200, Thomas Gleixner wrote:
> ktime_get_snapshot() is replaced by ktime_get_snapshot_id() which allows to
> request a particular CLOCK ID to be captured along with the clocksource
> counter.
> 
> Convert the tracing mechanism over and use the new
> system_time_snapshot::sys field, which holds the system timestamp selected
> by the CLOCK ID argument.
> 
> No functional change intended.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: Vincent Donnefort <vdonnefort@google.com>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Oliver Upton <oliver.upton@linux.dev>
> Cc: kvmarm@lists.linux.dev

Acked-by: Vincent Donnefort <vdonnefort@google.com>

> ---
>  arch/arm64/kvm/hyp_trace.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> --- a/arch/arm64/kvm/hyp_trace.c
> +++ b/arch/arm64/kvm/hyp_trace.c
> @@ -51,8 +51,8 @@ static void __hyp_clock_work(struct work
>  
>  	hyp_clock = container_of(dwork, struct hyp_trace_clock, work);
>  
> -	ktime_get_snapshot(&snap);
> -	boot = ktime_to_ns(snap.boot);
> +	ktime_get_snapshot_id(&snap, CLOCK_BOOTTIME);
> +	boot = ktime_to_ns(snap.sys);
>  
>  	delta_boot = boot - hyp_clock->boot;
>  	delta_cycles = snap.cycles - hyp_clock->cycles;
> @@ -118,9 +118,9 @@ static void hyp_trace_clock_enable(struc
>  		hyp_clock->running = false;
>  	}
>  
> -	ktime_get_snapshot(&snap);
> +	ktime_get_snapshot_id(&snap, CLOCK_BOOTTIME);
>  
> -	hyp_clock->boot = ktime_to_ns(snap.boot);
> +	hyp_clock->boot = ktime_to_ns(snap.sys);
>  	hyp_clock->cycles = snap.cycles;
>  	hyp_clock->mult = 0;
>  
> 

