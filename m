Return-Path: <netdev+bounces-200815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D571AE7028
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 21:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E2743B10D4
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 19:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01042E2EE3;
	Tue, 24 Jun 2025 19:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="Nh9SL7Sc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056372E92C1
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 19:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750794552; cv=none; b=lanULWrGeWf8p1Pw6PYG3dtQFy4l+JWeJvy4tWRZL7w00W3WTbsSFaGTzdd453a8ggwLxwq6r7onUxv15vhXLdc8NAA/y9M6pFrFc+lvMWLEHKLUDk+i/c8TwUqb4nnPWWccz/bW2oGsocMqpfBF+2XPqjD5NExt00ZOivX8UH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750794552; c=relaxed/simple;
	bh=84iEEQ5zcFz6F0qxkt3i0soW6FCDAA0P690dJ4N0ytE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jKl9rMHUelI4Gn9Wdw/gJSWAFCO3dWCtfzzGkiAIXRf3l/S0nIeRqLdB0O2yt9UmqmYVCr7JL9r3NmFlMOx3b+RFaud9QtMRxYofdizLbglNjHuBKa16oG1XxEi0MdKlQATF10zljp6IjIGuHiTsNbIY0JT1coNSoI2TxoxYT64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=Nh9SL7Sc; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7481adb0b90so268127b3a.1
        for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 12:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1750794550; x=1751399350; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TEMl6eJ3YJldsq7k3k18NC5vKc+7ht1rDEBshbgwz1A=;
        b=Nh9SL7ScVs065LUIGpzXJbWscmByfserfP1Jg6PvC8yjzJ/EZ86Gw6Ppl1cxFg/mXC
         jtr7mFsO7eW+hOdrfEUw9iFUpaHOfhd/RFEfJ/1wa86nHfruClVaACWHofQUCsSP/Z3U
         FPe3wZ8vmTutNS333jZIuBd2DFu9RSmeYtwwdpto7rfWpv6TetLRG0mMSFtf1tIsAkej
         MXFq2jzlKWqfmmctCVf7tLLgfDO1IYp0jopSDmiliNajxHTShbcvYuQFQEvUha4RAnLZ
         qEPBzp4hlUwsVLp02plTUtui651lBM/PvFXZTllsCHBHK7qMr0MeYgsJc84aqzPr484D
         GXPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750794550; x=1751399350;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TEMl6eJ3YJldsq7k3k18NC5vKc+7ht1rDEBshbgwz1A=;
        b=MV/GplplcEDxqlRAATOPN6dIO4r2e/uCYh11g9S8acTL9lvG2n0JxciDOlWEjcindm
         2/8DnUOZXMabbzBFRzFdektFC3WdgHSa8leZRBu26kSnHJJ79q/22nPH2r2rf36oTpct
         ftJyh6hmxIlYe7WDUe72qajhAoJiylme+y5UoAVY8NCYDP4kRdUavC0dnhIHHgJovZAJ
         g+oeDay+DfxmPxYoX2iQQQ9VF/R+qR1v9t1iGmJ4hx9DXU1T3/bFBWuBUuBAwMzrdTEJ
         qpfQ27cytQfUFzT+hi9JWtBcPoinLCD2SFDEpSBYgAXat5lw+47sQpAh2Aosga4/SVSm
         qipA==
X-Gm-Message-State: AOJu0YwIBT4YxyGct6PjSMJQzI/evqzrbdZsZNk0js/1D3E+DeuOSChw
	utvMSPE/QtQV5W7vPAnvBIrOfZkFcJ5gQfz6KiS4CK6oeXCWShg1Pp66n/ebuZP3UXM=
X-Gm-Gg: ASbGnctKeN5REoNkYtzToHMBPIqH/9Dqk0A5GiMGHofkkPEs6H+175rMXEeNfRtlSbd
	XggQG/lvvniZwaQwS/lDw//LhxXxgm2v5EWziXQZPev8TMC3CaScP7fwXcALyHrzhCho8qwh+qA
	YwHEN0/iaer5kWognlXFVMFelRK3sMvgdBCn8rzQP2SywELy8DadtohaHbWVMHQAF0O7OiSBWLD
	f4d663AeCMfHwp5GdVJSgS/nNegpxCkruy08gqPGcifGAslJeQ5f9CVwa1IIw7FPJhdGpPYCVRM
	Zd+/mvDDZMm7tL6sOsW46mQ3nyHxEQ8kKEKMOxIlfgnrKR0=
X-Google-Smtp-Source: AGHT+IG+qBW4zr65fekP5/GsWiiX7SdOGOxL18FEHTp64/LOAjCnzrksvNIX70PxM/joR+Sj9G6dQQ==
X-Received: by 2002:a05:6a00:349b:b0:736:a9b1:722a with SMTP id d2e1a72fcca58-74ad4610130mr181731b3a.7.1750794550260;
        Tue, 24 Jun 2025 12:49:10 -0700 (PDT)
Received: from t14 ([2a00:79e1:abc:133:b63c:7792:e98f:f4a5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-749b5e21931sm2719417b3a.56.2025.06.24.12.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 12:49:09 -0700 (PDT)
Date: Tue, 24 Jun 2025 12:49:07 -0700
From: Jordan Rife <jordan@jrife.io>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: [RESEND PATCH v2 bpf-next 02/12] bpf: tcp: Make sure iter->batch
 always contains a full bucket snapshot
Message-ID: <posiabqearkkbt3o4l4yueyn3kl6jvw2r4fuxceabgju2etg7x@m7fepnnvkgjj>
References: <20250618162545.15633-1-jordan@jrife.io>
 <20250618162545.15633-3-jordan@jrife.io>
 <aFMJHoasszw3x2kX@mini-arch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFMJHoasszw3x2kX@mini-arch>

> Can we try to unroll this? Add new helpers to hide the repeating parts,
> store extra state in iter if needed.
> 
> AFAIU, we want the following:
> 1. find sk, try to fill the batch, if it fits -> bail out
> 2. try to allocate new batch with GPU_USER, try to fill again -> bail
>    out
> 3. otherwise, attempt GPF_NOWAIT and do that dance where you copy over
>    previous partial copy
> 
> The conditional put in bpf_iter_tcp_put_batch does not look nice :-(

With the unrolling, I think it should be simple enough to just call
bpf_iter_tcp_put_batch in the right place instead of embedding it inside
bpf_iter_tcp_realloc_batch conditional. Agree this might be clearer.

> Same for unconditional memcpy (which, if I understand correctly, only
> needed for GFP_NOWAIT case). I'm 99% sure your current version works,

This matters for both cases. Later in this series, this memcpy is
necessary to copy socket cookies stored in iter->batch to find our place
in the bucket again after reacquiring the lock. IMO this still belongs
here; in both cases, we need to copy the contents from the old batch
before freeing it.

> but it's a bit hard to follow :-(
> 
> Untested code to illustrate the idea below. Any reason it won't work?

After revisiting the code, I now remember why I didn't do something like
this before.

> 
> /* fast path */
> 
> sk = tcp_seek_last_pos(seq);
> if (!sk) return NULL;
> fits = bpf_iter_tcp_fill_batch(...);
> bpf_iter_tcp_unlock_bucket(iter);
> if (fits) return sk;
> 
> /* not enough space to store full batch, try to reallocate with GFP_USER */
> 
> bpf_iter_tcp_free_batch(iter);
> 
> if (bpf_iter_tcp_alloc_batch(iter, GFP_USER)) {
> 	/* allocated 'expected' size, try to fill again */
> 
> 	sk = tcp_seek_last_pos(seq);

Since you release the lock on the bucket above, and it could have
changed in various interesting ways in the meantime (e.g. maybe it's
empty now), tcp_seek_last_pos may have moved on to a different bucket.

> 	if (!sk) return NULL;
> 	fits = bpf_iter_tcp_fill_batch(...);

If that new bucket is bigger then this fails and we immediately move
onto the GFP_NOWAIT block. Before, we were trying to avoid falling back
to GFP_NOWAIT if possible; it was only there to ensure we could capture
a full snapshot in case of a fast-growing bucket. With the unrolled
logic, we widen the set of scenarios where we use GFP_NOWAIT. With the
loop (goto again) we would just realloc with GFP_USER if the bucket had
advanced. The original intent was to try GFP_USER once per bucket, but
unrolling shifts this to once per call.

> 	if (fits) {
> 		bpf_iter_tcp_unlock_bucket(iter);
> 		return sk;
> 	}
> }

Both approaches work. Overall, the unrolled logic is slghtly clearer
while making the GFP_NOWAIT condition slightly more likely while the
loop logic is slightly less clear while making the GFP_NOWAIT condition
less likely.

In practice, the difference is probably negligible though, so yeah it
might be better to just favor clarity here. Let me go ahead and try to
unroll this. If I run into any issues which make it impracical I'll let
you know.

Jordan

