Return-Path: <netdev+bounces-237741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 085AEC4FCC1
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 22:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F3D2D4FBD9B
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 21:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F387C352FA0;
	Tue, 11 Nov 2025 21:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EMZ27BoX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2C6352F96
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 21:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762894917; cv=none; b=MQmVY0rgNH0ADFQbf30UC4v1g3LzHh7GOKLqWioo7QMzXPtZTJs/RBDXEumUl4nQQlc4Rll5annDc32fqMhB3P245oZ/M2X+i7mfF6mr6FIj3uosm3aKLl1L8VigKGhJVxEpyGUebP8gLCcXWv39ACu3Oxc/Uqbs8NcSRtoOM+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762894917; c=relaxed/simple;
	bh=m2/ll1uTQe3vdYyhgsBOhN/isiT4ncOezX9iuBFvWf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NtGLQmwTGy9lcbBtk4lgKhGYjDY5Y8p4ysW+x84nGV0x18o0uoyqob5jWZZb2/wIQv50ouqznwGuJlL0egIbrBMAIRRrl9z1AZL4YhBvQ39qmnJ2L7Dv94qNcPYogWhT69YVN/cl7xHXXCVBR7+v41YSjBdKsYOWaIc5KI63mbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EMZ27BoX; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-640c857ce02so197752d50.0
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 13:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762894911; x=1763499711; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bDPq8KvClJvWwDQMfmOhMgSMTNNkWL2W9UB4UAss5Bg=;
        b=EMZ27BoXyrccnWk6j0fZzJXConxIlnb+YJyxYnU4pvHMuVIow6oNh0p44L4eeNPAlb
         EuU22N0Cu3NLv75bupq/7aQaIC76fv8insPYQvRVpLLgtxNnYfaxq1leWkBbQwLqpal1
         dN2H45GfOTIZMIalPt3j+RAvbeKU5LUk5X4jrrgVx77EbEaniLj25o8hJrBzM2OzXDLb
         6EjMCrvHtPJKTl0XLha4W+sb/tyBJSEidqBbro/8EAwK29bMgtOQYDZxKcG0Ho3RXKmv
         B9Z4B6oHilKtSi+F0GDPzi4IS6pGJKPuoMNThYrWpESSL160+clnPrk3ZeGhyMlHRBO2
         OiMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762894911; x=1763499711;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bDPq8KvClJvWwDQMfmOhMgSMTNNkWL2W9UB4UAss5Bg=;
        b=Ma/C1041nm1bB+VGr/XVTgiwCEwGs+b951oeNeOrGYOxjMgXydAO3l9Z9Few+3Vc5b
         /6qvmmZ3DOIrgV+PZC6LP/EKQpy7jaqmWy9Dz0MQd3bdwo3eK6JXJtB/8YRA5kpL+Vly
         NNve2hnN834T3Izb0ehGpjKJoI6AHyVJgBNCyp/6np3IUdift6BvVlbyVDW5mYBICl2C
         NjvkUjHZXfvWoK43pO2FukTbxzdLhXbv5wqGfRnz7d/F7W+4QLMoTGM/U/8A7F6Mo8ae
         fONah2wtWE5Gu//mifvY4zgkz11RcQ5lxgvjnuuJ8DD5PzeRFORiQDSzbi715+lrwUew
         Yc2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXbL/f1Fmu6oQGNrb2RmtCjy3qsW/Gz8arI+iMkgJGLLyUeR2Du1yxxAPN8KiVcS2zh/mN5Nxc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHXTR6/P6SN7W8mQ/brsWYEJnkuH9R9ty1LJgDQzXEfFKWeTDM
	LpCojG6bEDQsQ3U+1mmtU+OFhBWheti3KlvtgnZ9bvDk/NqHjtdMJhid
X-Gm-Gg: ASbGncslVwSUMrDas9mrhTAhhvcRYcHbc99nYCBMHEx8voWMx+JUJ5fyolGBBaGI2Eh
	MuGcOSjVDfgmDrIMsLXwfDrB3Cl97iHjl1ECSuEAxkbHKnU5K7zMJTwxzOnF+WVvt7uduyKwrIa
	OwmCP7CkQhkKfJHcq8Uo0KXKN5xtn4DLa+phbVHPlNrrHP83UOE9yZ7C5B1b6hMu14XxC6xhYYd
	b54TPMio5WDFDCw8lRtOyRgbZBei6EbWP2o3Ji2Ol7WgRqvSKRfpeKNnXO65her3T5NhLhjrbw2
	lgIzvVmFaGVU/QMFOsYXcbpcpMVVGWqNDkdL62mZ4xR5x5RLxY9IjkHDDzPHYlqubAepb0lt60y
	EpQ5hkHsvtURh23ov3Dq/mtLWnauWZ47uLPYnOA6FAaIEHYqopQxW6w7dbImGDhDh43xUYTAcl+
	WoV35s7nonROVN5uO0/bx1A/d30wmIOZWf7kKSYBCjfznESA==
X-Google-Smtp-Source: AGHT+IG5pLwkGsZ+eCK296l8q5rg85wfM1wAQ8NbbJwGyjxk6/mldP/Q7Z6BLYOivEyqJVyS1VY/EA==
X-Received: by 2002:a53:c048:0:20b0:63f:a165:b9ed with SMTP id 956f58d0204a3-64101a0ab45mr674439d50.6.1762894911625;
        Tue, 11 Nov 2025 13:01:51 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:d::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-787d684218dsm36167807b3.21.2025.11.11.13.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 13:01:49 -0800 (PST)
Date: Tue, 11 Nov 2025 13:01:48 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v3 07/11] selftests/vsock: add check_result()
 for pass/fail counting
Message-ID: <aROkPIIeGq3Tb0I6@devvm11784.nha0.facebook.com>
References: <20251106-vsock-selftests-fixes-and-improvements-v3-0-519372e8a07b@meta.com>
 <20251106-vsock-selftests-fixes-and-improvements-v3-7-519372e8a07b@meta.com>
 <aRMjeZVqsnc1BNr-@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRMjeZVqsnc1BNr-@horms.kernel.org>

On Tue, Nov 11, 2025 at 11:52:25AM +0000, Simon Horman wrote:
> On Thu, Nov 06, 2025 at 04:49:51PM -0800, Bobby Eshleman wrote:
> > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > 
> > Add check_result() function to reuse logic for incrementing the
> > pass/fail counters. This function will get used by different callers as
> > we add different types of tests in future patches (namely, namespace and
> > non-namespace tests will be called at different places, and re-use this
> > function).
> > 
> > Reviewed-by: Simon Horman <horms@kernel.org>
> > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> > ---
> > Changes in v3:
> > - increment cnt_total directly (no intermediary var) (Stefano)
> > - pass arg to check_result() from caller, dont incidentally rely on
> >   global (Stefano)
> > - use new create_pidfile() introduce in v3 of earlier patch
> > - continue with more disciplined variable quoting style
> > ---
> >  tools/testing/selftests/vsock/vmtest.sh | 95 +++++++++++++++++++++++++--------
> >  1 file changed, 72 insertions(+), 23 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
> > index 557f9a99a306..05cf370a3db4 100755
> > --- a/tools/testing/selftests/vsock/vmtest.sh
> > +++ b/tools/testing/selftests/vsock/vmtest.sh
> > @@ -46,6 +46,8 @@ readonly TEST_DESCS=(
> >  	"Run vsock_test using the loopback transport in the VM."
> >  )
> >  
> > +readonly USE_SHARED_VM=(vm_server_host_client vm_client_host_server vm_loopback)
> > +
> >  VERBOSE=0
> >  
> >  usage() {
> > @@ -79,6 +81,28 @@ die() {
> >  	exit "${KSFT_FAIL}"
> >  }
> >  
> > +check_result() {
> > +	local rc arg
> > +
> > +	rc=$1
> > +	arg=$2
> > +
> > +	cnt_total=$(( cnt_total + 1 ))
> > +
> > +	if [[ ${rc} -eq $KSFT_PASS ]]; then
> > +		cnt_pass=$(( cnt_pass + 1 ))
> > +		echo "ok ${num} ${arg}"
> > +	elif [[ ${rc} -eq $KSFT_SKIP ]]; then
> > +		cnt_skip=$(( cnt_skip + 1 ))
> > +		echo "ok ${num} ${arg} # SKIP"
> > +	elif [[ ${rc} -eq $KSFT_FAIL ]]; then
> > +		cnt_fail=$(( cnt_fail + 1 ))
> > +		echo "not ok ${num} ${arg} # exit=$rc"
> 
> Hi Bobby,
> 
> Should num be cnt_total above?
> 
> > +	fi
> > +
> > +	cnt_total=$(( cnt_total + 1 ))
> 
> It seems that cnt_total is being incremented twice.
> Once seems like it ought to be enough.
> 

Indeed. FWIW, this was fixed in the newest (v4). I messed up a rebase,
and my eye didn't catch it before sending out.

> > +}
> > +
> >  vm_ssh() {
> >  	ssh -q -o UserKnownHostsFile=/dev/null -p ${SSH_HOST_PORT} localhost "$@"
> >  	return $?
> 
> I'll confess that I didn't notice these myself, but
> Claude Code with https://github.com/masoncl/review-prompts/ did.

Thanks for the note, I'll give it a try. I'm trying to build out my
pre-send workflow atm, and this looks pretty useful.

Best,
Bobby

