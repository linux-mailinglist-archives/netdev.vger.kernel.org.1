Return-Path: <netdev+bounces-223190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE8BB58326
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 19:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEA5F1A23163
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 17:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762B22DCBF4;
	Mon, 15 Sep 2025 17:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Az9n0gr7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7494E2D9EC5
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 17:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757956422; cv=none; b=WFN2xE7GGx5BKF2AE8cPMDVR0LgxyMLNrpugPLtQVK5UkTSdp8XDULAJJH+Vp/c9oaK/Xc2BtqKZDiPiX2vNoYmIHZhPnz6xgcPaNo9NFydzqvold3ap8+vOe4s/+vX/juTixknq3DcbGBYh+aiI7vKrPaDHs081cD35ZccX+IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757956422; c=relaxed/simple;
	bh=/CUKX5C/JOUX9o03xfQXMW/qD91kFk00c9sQWHjtdcI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pbs9knwBLZgipL5/y4weoKp2nIOZ2lhmInhUytvI2pOfIk7XGJfrO3lQpX2R1olQVCUjNZelk+TjC4iX0dgDIIn52LuF8th/e2jC7VVdkt4dRGH2Se2Po7QJM/+6mMcg4xzW+kID1BQr2ZdHIk7eppo30BLCGeCxIBEAF4iO+qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Az9n0gr7; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3ec4d6ba0c7so69298f8f.1
        for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 10:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757956419; x=1758561219; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/CUKX5C/JOUX9o03xfQXMW/qD91kFk00c9sQWHjtdcI=;
        b=Az9n0gr72l0D2XdW/5AjTY15fcvm0cldNI00TesnxXCwQuBW0uinaMvt0tXdo49jSK
         X+P5GvHfQuI/ob3r0slFNVI664pHFKMJTKezCOTWku/1w1KT3HzPGuGHeD1gVPyqOEe0
         EmOACodwUf06fYrut9hrJui3nIGqdVoTbFQYu55heLmCoXm+CEYef1UjLCCHbFirn7Wp
         2xHvQ4sh0qYVpwP29cZzzMAKL15fQ2l1YrnfKPCaB7TxMlfuoAFKgg2veJhawpMdI5JF
         qTjrcnZmn8fR3XvXzHuf/Y/8vUJm8B1IhwoXLzuNM8Mq6f9GCCSrWWYyGzbvuGwX5zdJ
         +F3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757956419; x=1758561219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/CUKX5C/JOUX9o03xfQXMW/qD91kFk00c9sQWHjtdcI=;
        b=Wtbm5/Q3p5fShVVeTN2cUzbmWRS44ugWTjleb+UmI8u5DuMx0p3wrOjKGtg7cC/lLQ
         Q7G1OJM9quiZeRhFRoNtxrPD4DJfrelo9lhk6owd2oahIfn5DPR0ffsunFwhu09uuRv+
         +MB8yfVXMgjnPYCTRk0pXwyXDIWG7YFJXABe6Ni55DMIMZBkXEmQ0pa9aaci8tBcWilo
         18Lumd8GX52mr7P6ewLOmPNGkuoPO9Ie8ih92nyQTDmYr9pwoZsSlKII2+46oei94cXM
         n8xQ6SrC0r3GrDb0hVBwsxH6cXmvtiY7WwSQ826ogAJKOK2IB9/d0a0uGjV5403dKJBC
         IA1A==
X-Forwarded-Encrypted: i=1; AJvYcCVHCT4hCCCegZ9222ZIcNNUNEEm3Y/nKRv5XSOvTE2rWryqmw/3hT+D2Hs8Ncpt5YhnhIgU6uk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwiwwtiW6J5rqikauXd3ouX9jcMliFc/hPipp/lN72rXe/mh/3
	q7ZKHZU+ZxAPkhJlXPiGk0IZWR3tkLZ/t+5taKgsPrs/2zCDHvjH8qbIAw9naQkybraa+jT4Qmt
	MRb1M3c/UmwzGi0M2bpRm8iBGvd5MRrk=
X-Gm-Gg: ASbGncsMIePjCfHq0mjwO/vhGdHzTu/c8DZLCb32RZcO2tJmCeFrhR2VG7SRBrG8jNH
	CChRZrqRGn6WfNT5vWYmvlvLstZuQfA2uEH/2HPcERjT6MAaqigBCG+FN0UEvvIl5WkthZ8P3FT
	kEtdCICGQTMy+nYaU2C+VrnnKYoOSfAASwJ3bDaPpBMvHu+Nzq2Y+U00ftPBmoehhX7VGQn+YIh
	sbsEw5e0hev22L/2H9b58o=
X-Google-Smtp-Source: AGHT+IFQp6tKSn0h8An2pvTCG8CcE6ze9qvxAkcXYS50TGAKAo3NTyQJ4AabHE3UlQlaIVm6zqWqil99iG9syQhTs44=
X-Received: by 2002:a05:6000:2283:b0:3e7:6196:fdf2 with SMTP id
 ffacd0b85a97d-3e765a0981amr9879648f8f.47.1757956418497; Mon, 15 Sep 2025
 10:13:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904-xsk-v3-0-ce382e331485@bootlin.com> <aLmfXuSwtQgwrCRC@boxer>
In-Reply-To: <aLmfXuSwtQgwrCRC@boxer>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 15 Sep 2025 10:13:24 -0700
X-Gm-Features: AS18NWBMiMS6XvzTlqJcTup9x50Fctx117wBc5Bi97DEiXSlmnUcLqRrkzlqQoo
Message-ID: <CAADnVQKSHuFgd9KbAv_dUTiS2de=crjDtNLAp5tt7DhBQgZWEg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 00/14] selftests/bpf: Integrate test_xsk.c to
 test_progs framework
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	Alexis Lothore <alexis.lothore@bootlin.com>, Network Development <netdev@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 7:17=E2=80=AFAM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Thu, Sep 04, 2025 at 12:10:15PM +0200, Bastien Curutchet (eBPF Foundat=
ion) wrote:
> > Hi all,
> >
> > This is a second version of a series I sent some time ago, it continues
> > the work of migrating the script tests into prog_tests.
> >
> > The test_xsk.sh script covers many AF_XDP use cases. The tests it runs
> > are defined in xksxceiver.c. Since this script is used to test real
> > hardware, the goal here is to leave it as it is, and only integrate the
> > tests that run on veth peers into the test_progs framework.
> >
> > Some tests are flaky so they can't be integrated in the CI as they are.
> > I think that fixing their flakyness would require a significant amount =
of
> > work. So, as first step, I've excluded them from the list of tests
> > migrated to the CI (see PATCH 13). If these tests get fixed at some
> > point, integrating them into the CI will be straightforward.
> >
> > PATCH 1 extracts test_xsk[.c/.h] from xskxceiver[.c/.h] to make the
> > tests available to test_progs.
> > PATCH 2 to 5 fix small issues in the current test
> > PATCH 7 to 12 handle all errors to release resources instead of calling
> > exit() when any error occurs.
> > PATCH 13 isolates some flaky tests
> > PATCH 14 integrate the non-flaky tests to the test_progs framework
> >
> > Maciej, I've fixed the bug you found in the initial series. I've
> > looked for any hardware able to run test_xsk.sh in my office, but I
> > couldn't find one ... So here again, only the veth part has been tested=
,
> > sorry about that.
>
> Hi Bastien,
>
> just a heads up, I won't be able to review this until 15 sept. If anyone
> else would pick this up earlier then good, otherwise please stay patient
> :)

Maciej,
Sep 15 is today... just bumping it in your todo list :)
Pls take a look.

