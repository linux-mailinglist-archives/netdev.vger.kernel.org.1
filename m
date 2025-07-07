Return-Path: <netdev+bounces-204598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DCDAFB64D
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 16:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED5B3189BFC7
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 14:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5302E11B0;
	Mon,  7 Jul 2025 14:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oN5rUh+e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259682DC355
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 14:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751899439; cv=none; b=W6wP1NVVKjrFmUr0UYl5NJI7jBEEo2van2kNbUu8bth4gxBXkfuqVzP8rfdY8o/7wQjr1HKiDKVkb02nhkDC9OP//fgkgTQcqwRSF2tAcALgMdq+qs6xoY+EmP5iwB/+2GnSFhxUV5Ei5hQOm/AmKfDYDu8wW1PS0nnY4mpmaSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751899439; c=relaxed/simple;
	bh=4SYzrfi8eSVNvgrXYXTFJYOb7UxzA2l6iu6VY3UyPek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M8q56fPTZnvX6cqVchJoY7Y3kOPY6Bg96VF+S/tB6iPaW6CeNf+o28E+dLWHIXqrCb1BCMk+5tYkezie702yFJhkGyHHUC27imwOitOQFs1vsVh5YZdApXdjX7/0ZPeQraloOzE/Gm4t0MRoiO4vIKJ6V1/wdKjOVlId5xfBD5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oN5rUh+e; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-748d982e97cso2921079b3a.1
        for <netdev@vger.kernel.org>; Mon, 07 Jul 2025 07:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751899437; x=1752504237; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+pTtsBnfUPWKdwsnA4BbdtfvUaJxWCar1qlbSLwHves=;
        b=oN5rUh+edi489LvVHiF4VzFKlf7dW/n2DXie2O9ZUEAycbPp2p+sPjhOdjuIuRfDOA
         AGZBgtY9NcCzW1diImHc8VVubD0Rn9F5om7JuB5e36ZPFeK1WMBJhrGCNCccEzWH27KT
         Zki9x52LOM+2zw4N0VlrVXwsdc8p013rTQigxp1S99HBCy3giaDO0dBlpWnNm5ZabDuk
         Pt8SzCZxlxPiq1VTDdiouFSzWra98Yhlhb9/1QARmAiM7/SNlKSJualHXpzISs106tVw
         PTcUnoS4rLBWXospWkV0BGiRyKD/q5UzgL55OA2AWay/Ua9NUKpXVoSWlf93e+rFwxME
         aFfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751899437; x=1752504237;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+pTtsBnfUPWKdwsnA4BbdtfvUaJxWCar1qlbSLwHves=;
        b=YeUge5gFUTuPGappuChlGLpUjg6l1Kbcvgi6kN+Ukx98YnLl8supR0X5/7tqkH4HXI
         M7485gm99g6BinZ7f93KEsYRBqybq5aI38UfJbkGLMTCmbumTYjIHHJwW7cEq+lr8tF/
         XXmAXPpQBmvBLF9U/EJ+UYsy2gdKRQLdsGH6RQ9N6RP01bDbgedCwb+QY24fXGwcPLY6
         0icGDNZnIy2cKExrWxfRzomzVLGKVrFKGV10R4LxSbD4K3UtHV28TC1Goc7EZVZcqBZp
         e5G98AIyGZNX5YhM6f3XvWfk6C9gChka1rCCYhi/ZPbwBeyMXzAP+6NuIsFicR2eSPoG
         LqWg==
X-Forwarded-Encrypted: i=1; AJvYcCX3CCQdil3Lhh0s5cc3nMrAEfFY/W8ySsZF47GLgnWjKIntrCDFOVn3hfTO19V8Uw43ndCpfwY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAighFTwPZemQCbL/dcT1kbkmkC0yizMmFhkr/vd3jv3oxQN8S
	8GbyyZ1NOcjBydbbebdRveInUvXS+TXupwYzFatDrJ9wQEGR+85e6R+qiWrcEWyFOQ==
X-Gm-Gg: ASbGnct5UgHIDh7h/h6XLyN73Wi5uw4ccJHkzWtPTt3Ym/I1tGOqbiPUZDLBSi2rr21
	rpSPeqKTZ4uFQEd+NnfFPytrOkmcmLC4n1PQM7N9/EvzKamocV3ev4+h8a5IZpsJyy1L82WCiRZ
	0wYJAgrpxmVxZjqr5rkn6IL4kw3sV9Kg2FxuR6sr3XyKkE+Z1FaJnVUovExGsIk4zoFQmW0qed5
	j1S0cT/cD6MdbWChopLU5f03ZvNE9rs07g+oiUZRdxlqsjsRLYbvCnqtu9veCtWAqzhXz9qyWo1
	ezN7/EhL+FOQq5v5vKh7E23QxMJfncyyY39DVRnN5G5uqvGk2WArOFodnOSvjNWkc/omztIGzRS
	HOwso3jhxZWmIXg1F7oqs
X-Google-Smtp-Source: AGHT+IENvRRf5tUPo69YOT6uAn+DdF7ZOsJOzzGu9fBHcNFbHwWb7BTYa3THLSTaN4s2a43/eCH6ew==
X-Received: by 2002:a05:6a00:14c9:b0:748:eb38:8830 with SMTP id d2e1a72fcca58-74ce6669b0emr15965469b3a.13.1751899437039;
        Mon, 07 Jul 2025 07:43:57 -0700 (PDT)
Received: from google.com (20.25.197.35.bc.googleusercontent.com. [35.197.25.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce417ddc9sm9936838b3a.105.2025.07.07.07.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 07:43:56 -0700 (PDT)
Date: Mon, 7 Jul 2025 14:43:48 +0000
From: Brian Vazquez <brianvv@google.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Joshua A Hay <joshua.a.hay@intel.com>, 
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, Brian Vazquez <brianvv@google.com>
Subject: Re: [Intel-wired-lan] [PATCH net 0/5] idpf: replace Tx flow
 scheduling buffer ring with buffer pool
Message-ID: <yhluj2ljtv4qoq65zfqoagwdwshokfmzylf52numl26skxqfp4@k3dm7jrimuis>
References: <20250625161156.338777-1-joshua.a.hay@intel.com>
 <c4f80a35-c92b-4989-8c63-6289463a170c@molgen.mpg.de>
 <DM4PR11MB65024CB6CF4ED7302FDB9D58D446A@DM4PR11MB6502.namprd11.prod.outlook.com>
 <c6444d15-bc20-41a8-9230-9bb266cb2ac6@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c6444d15-bc20-41a8-9230-9bb266cb2ac6@molgen.mpg.de>

O Mon, Jun 30, 2025 at 06:22:11PM +0200, Paul Menzel wrote:
> Dear Josh,
> 
> 
> Am 30.06.25 um 18:08 schrieb Hay, Joshua A:
> 
> > > Am 25.06.25 um 18:11 schrieb Joshua Hay:
> > > > This series fixes a stability issue in the flow scheduling Tx send/clean
> > > > path that results in a Tx timeout.
> > > > 
> > > > The existing guardrails in the Tx path were not sufficient to prevent
> > > > the driver from reusing completion tags that were still in flight (held
> > > > by the HW).  This collision would cause the driver to erroneously clean
> > > > the wrong packet thus leaving the descriptor ring in a bad state.
> > > > 
> > > > The main point of this refactor is replace the flow scheduling buffer
> > > 
> > > … to replace …?
> > 
> > Thanks, will fix in v2
> > 
> > > > ring with a large pool/array of buffers.  The completion tag then simply
> > > > is the index into this array.  The driver tracks the free tags and pulls
> > > > the next free one from a refillq.  The cleaning routines simply use the
> > > > completion tag from the completion descriptor to index into the array to
> > > > quickly find the buffers to clean.
> > > > 
> > > > All of the code to support the refactor is added first to ensure traffic
> > > > still passes with each patch.  The final patch then removes all of the
> > > > obsolete stashing code.
> > > 
> > > Do you have reproducers for the issue?
> > 
> > This issue cannot be reproduced without the customer specific device
> > configuration, but it can impact any traffic once in place.
> 
> Interesting. Then it’d be great if you could describe that setup in more
> detail.
> 

Hey Paul,

The hardware can process packets and return completions out of order;
this depends on HW configuration that is difficult to replicate.

To match completions with packets, each packet with pending completions
must be associated to a unique ID.  The previous code would occasionally
reassigned the same ID to multiple pending packets, resulting in
resource leaks and eventually panics.

The new code uses a much simpler data structure to assign IDs that is immune to duplicate assignment, and also much more efficient at runtime.
> > > > Joshua Hay (5):
> > > >     idpf: add support for Tx refillqs in flow scheduling mode
> > > >     idpf: improve when to set RE bit logic
> > > >     idpf: replace flow scheduling buffer ring with buffer pool
> > > >     idpf: stop Tx if there are insufficient buffer resources
> > > >     idpf: remove obsolete stashing code
> > > > 
> > > >    .../ethernet/intel/idpf/idpf_singleq_txrx.c   |   6 +-
> > > >    drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 626 ++++++------------
> > > >    drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  76 +--
> > > >    3 files changed, 239 insertions(+), 469 deletions(-)
> 
> 
> Kind regards,
> 
> Paul

