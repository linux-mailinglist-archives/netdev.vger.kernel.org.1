Return-Path: <netdev+bounces-154716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B41E79FF8EF
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 12:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCCB01881DFB
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 11:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164BA190051;
	Thu,  2 Jan 2025 11:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PO+BhgnD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2FC13C9A3
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 11:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735818427; cv=none; b=XmtFLUoMD3Es9eh5McEdApGDy4AJJWJDPcalpiGsQHWCeOqn4vjoeqBfxV4qMIIV3fu1t47tO69bwrfh4+LqxwkLHK3A1W9gUSDVlBMrR5uWu2VqYft3YNJesNR1XxQdXvuArm+9L0OPbJ/gxY98vxhHp7YfhX1VKVQdefB6nas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735818427; c=relaxed/simple;
	bh=sF+g00QEE/+9JFZEew+k5/vn8HmjvxLQn5G8Vw1SHOo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vym2lGS12SgFYeXtYa9BRSeTmx5HEQC63GhEE1MPSBMBBSfU7meLQEtqLx2NlsaYgTno9tLC2z+/O2BocKBCUu79XCnb5h3yR8CJIhCIyCLzbxEJt6DuepmbwQRIMvH33BHmLYTwBk0nwLkP4kSOsbIG8NWlN+X3BYI3Qro/H2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PO+BhgnD; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aae81f4fdc4so1740284566b.0
        for <netdev@vger.kernel.org>; Thu, 02 Jan 2025 03:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1735818423; x=1736423223; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s0YMxFvTR89OUfZaD3QYFUwk+Kdex/zYhmYqlBBl7SY=;
        b=PO+BhgnDtTMNLbJNnxgtmPi4ksUSunooK1u3XXCbEL3GVXFYtkj7TCmu9MFSFBoQCV
         WBbMqmVEvFceIDe1FXS40lC8Vgn1rnCRRlUgvvGfuXrLZxrbMH+vYqP5dHbAPQo4Pwyf
         c2ZxzXy04HHaBcnOsyrlCli/Y5p/AC7YTA/fliUrFr5pbC8Mg0NvKJvT1D82AvT6zXrx
         6ojrptpVd1EGENN2dN0Cpn4zt3ksPEK/V6GlJn6XOadpGG9qGcQPy2fRh+vb69enN+/O
         mmjh7sh5x596YoN8LCCVpSEOevRpCiVB2dPjBHc9ThPXp9BUts97A9yNyx04cqOKK8Fk
         6pOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735818423; x=1736423223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s0YMxFvTR89OUfZaD3QYFUwk+Kdex/zYhmYqlBBl7SY=;
        b=PI7bYENhraR1NAY7/zbKkZX6uC7h5KCDOLO/l2yzJErVXUB1j2GfBcV5Lxf9vpGXWP
         cezxhobWI0R3lsfiO9oUXLbYeGCz8xZ5OuwoBbvxAD4mucppzexWMDzpMAoaa+rFJ+Mm
         Qr4IAJ6p7R35G761wDgJyN5btMGmv12BriQajw6VRo9EdsWVpW4TE/vPbDESGZ8izjHI
         Qu9LAWwPAS3/UT17AlgqPc5ob3qudxE/kmqjkPik6A166uKvLTSmt7wCvQhPlxDcMl9B
         O1EG1OePiqdyZk91SmAse/1PSyk2cc9PE2uFCPHCXFBo0dQeiRyHZ7MFLb1H0wdM+yHR
         Ny2w==
X-Forwarded-Encrypted: i=1; AJvYcCVbs/5SFc7O/ffKRwqiYfOyb6YwtZ89hjhHHO2A2ZwrlZvnWkT+4oWHlTX5tS3HxM0+Rb4Ouu8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQPWTMqBl3qRiUA5Cw/ODLrrRgtfR5OQmJqFbnIHa28Bozp0MJ
	16nFxRPolg+8MsVxtXgGeucx5mP/gPqS0cvEo36vJVPvRq/FtTzrZjEGwMP80LOtsnevP3NpToT
	OxvJdY0j9Ndr1VEp7E1lSwrb36vcO+dWmTmt5
X-Gm-Gg: ASbGncvYj3PH50MIYlQPRwdmkacPXdEIeI2KzxhDWbtTriXbX8oh6qsN++7emH1BsU7
	UbyyJQMPXFPXi0uKL3XU538HLnrQsyXsnNexBNQ==
X-Google-Smtp-Source: AGHT+IHMS6327aM/I7sq/DNSg6+ALjDW+MpVCLsUrouDMM8e9gYTaMP3053qoEqS0wE3FMlpumzaE2t4mVs39VPasJc=
X-Received: by 2002:a17:907:7286:b0:aa6:79fa:b487 with SMTP id
 a640c23a62f3a-aac28a2ab8fmr4149628866b.10.1735818423359; Thu, 02 Jan 2025
 03:47:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <da83df12-d7e2-41fe-a303-290640e2a4a4@shopee.com>
 <CANn89iKVVS=ODm9jKnwG0d_FNUJ7zdYxeDYDyyOb74y3ELJLdA@mail.gmail.com>
 <c2c94aa3-c557-4a74-82fc-d88821522a8f@shopee.com> <CANn89iLZQOegmzpK5rX0p++utV=XaxY8S-+H+zdeHzT3iYjXWw@mail.gmail.com>
 <b9c88c0f-7909-43a3-8229-2b0ce7c68c10@shopee.com>
In-Reply-To: <b9c88c0f-7909-43a3-8229-2b0ce7c68c10@shopee.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 2 Jan 2025 12:46:52 +0100
Message-ID: <CANn89iLbC3qkeptG9xv1nZyWHUTdtXBf4w3LGaisRGc7xj4pMw@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BQuestion=5D_ixgbe=EF=BC=9AMechanism_of_RSS?=
To: Haifeng Xu <haifeng.xu@shopee.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 2, 2025 at 12:23=E2=80=AFPM Haifeng Xu <haifeng.xu@shopee.com> =
wrote:
>
>
>
> On 2025/1/2 18:34, Eric Dumazet wrote:
> > On Thu, Jan 2, 2025 at 9:43=E2=80=AFAM Haifeng Xu <haifeng.xu@shopee.co=
m> wrote:
> >>
> >>
> >>
> >> On 2025/1/2 16:13, Eric Dumazet wrote:
> >>> On Thu, Jan 2, 2025 at 4:53=E2=80=AFAM Haifeng Xu <haifeng.xu@shopee.=
com> wrote:
> >>>>
> >>>> Hi masters,
> >>>>
> >>>>         We use the Intel Corporation 82599ES NIC in our production e=
nvironment. And it has 63 rx queues, every rx queue interrupt is processed =
by a single cpu.
> >>>>         The RSS configuration can be seen as follow:
> >>>>
> >>>>         RX flow hash indirection table for eno5 with 63 RX ring(s):
> >>>>         0:      0     1     2     3     4     5     6     7
> >>>>         8:      8     9    10    11    12    13    14    15
> >>>>         16:      0     1     2     3     4     5     6     7
> >>>>         24:      8     9    10    11    12    13    14    15
> >>>>         32:      0     1     2     3     4     5     6     7
> >>>>         40:      8     9    10    11    12    13    14    15
> >>>>         48:      0     1     2     3     4     5     6     7
> >>>>         56:      8     9    10    11    12    13    14    15
> >>>>         64:      0     1     2     3     4     5     6     7
> >>>>         72:      8     9    10    11    12    13    14    15
> >>>>         80:      0     1     2     3     4     5     6     7
> >>>>         88:      8     9    10    11    12    13    14    15
> >>>>         96:      0     1     2     3     4     5     6     7
> >>>>         104:      8     9    10    11    12    13    14    15
> >>>>         112:      0     1     2     3     4     5     6     7
> >>>>         120:      8     9    10    11    12    13    14    15
> >>>>
> >>>>         The maximum number of RSS queues is 16. So I have some quest=
ions about this. Will other cpus except 0~15 receive the rx interrupts?
> >>>>
> >>>>         In our production environment, cpu 16~62 also receive the rx=
 interrupts. Was our RSS misconfigured?
> >>>
> >>> It really depends on which cpus are assigned to each IRQ.
> >>>
> >>
> >> Hi Eric,
> >>
> >> Each irq was assigned to a single cpu, for exapmle:
> >>
> >> irq     cpu
> >>
> >> 117      0
> >> 118      1
> >>
> >> ......
> >>
> >> 179      62
> >>
> >> All cpus trigger interrupts not only cpus 0~15.
> >> It seems that the result is inconsistent with the RSS hash value.
> >>
> >>
> >
> > I misread your report, I thought you had 16 receive queues.
> >
> > Why don't you change "ethtool -L eno5 rx 16", instead of trying to
> > configure RSS manually ?
>
> Hi Eric,
>
> We want to make full use of cpu resources to receive packets. So
> we enable 63 rx queues. But we found the rate of interrupt growth
> on cpu 0~15 is faster than other cpus(almost twice). I don't know
> whether it is related to RSS configuration. We didn't make any changes
> on the RSS configration after the server is up.
>
>
>
> FYI, on another server, we use Mellanox Technologies MT27800 NIC.
> The rate of interrupt growth on cpu 0~63 seems have little gap.
>
> It's RSS configration can be seen as follow:
>
> RX flow hash indirection table for ens2f0np0 with 63 RX ring(s):
>     0:      0     1     2     3     4     5     6     7
>     8:      8     9    10    11    12    13    14    15
>    16:     16    17    18    19    20    21    22    23
>    24:     24    25    26    27    28    29    30    31
>    32:     32    33    34    35    36    37    38    39
>    40:     40    41    42    43    44    45    46    47
>    48:     48    49    50    51    52    53    54    55
>    56:     56    57    58    59    60    61    62     0
>    64:      1     2     3     4     5     6     7     8
>    72:      9    10    11    12    13    14    15    16
>    80:     17    18    19    20    21    22    23    24
>    88:     25    26    27    28    29    30    31    32
>    96:     33    34    35    36    37    38    39    40
>   104:     41    42    43    44    45    46    47    48
>   112:     49    50    51    52    53    54    55    56
>   120:     57    58    59    60    61    62     0     1
>   128:      2     3     4     5     6     7     8     9
>   136:     10    11    12    13    14    15    16    17
>   144:     18    19    20    21    22    23    24    25
>   152:     26    27    28    29    30    31    32    33
>   160:     34    35    36    37    38    39    40    41
>   168:     42    43    44    45    46    47    48    49
>   176:     50    51    52    53    54    55    56    57
>   184:     58    59    60    61    62     0     1     2
>   192:      3     4     5     6     7     8     9    10
>   200:     11    12    13    14    15    16    17    18
>   208:     19    20    21    22    23    24    25    26
>   216:     27    28    29    30    31    32    33    34
>   224:     35    36    37    38    39    40    41    42
>   232:     43    44    45    46    47    48    49    50
>   240:     51    52    53    54    55    56    57    58
>   248:     59    60    61    62     0     1     2     3
>
>
> I am confused that why ixgbe NIC can dispatch the packets
> to the rx queues that not specified in RSS configuration.

Perhaps make sure to change RX flow hash indirection table on the
Intel NIC then...

Maybe you changed the default configuration.

ethtool -X eno5 equal 64
Or
ethtool -X eno5 default

