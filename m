Return-Path: <netdev+bounces-202325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6183AED5A3
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 09:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 298CC16A64A
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 07:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70801F866A;
	Mon, 30 Jun 2025 07:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KEbBY7Gu"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0331FBCB0
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 07:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751268629; cv=none; b=ib7xIvIj6DoalUiJKtNPlJF1bM2gIBdiD4v+KVfvGZ5LVbrhjtMyTwHgv8HXcgIsuIdR46vs2gjhwz6QqbUE3UTwSOFNEkNUYxC35LlI9PnP3h47Cs1HohOFvZVdEMBTky2l0tfQrLTxJ65Mu+9NIpU4Vv4UWQpLX/RU5Q7vQIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751268629; c=relaxed/simple;
	bh=rPeB+5Ycwh9FNWzFSBU0ZrdJKV+Sjr3Ks1H7BGUhkek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eSmc6MTttjw3hD7ZwG/JP2kOvoaJA1h1P/79BXLNrn1aQjmlAY6Bgp5mLoSJTAMoRF+TIP64Zd3/2YGars7gQZaOYoojroI0gwl7mngfSPwkBumlM3wasgSHmYcv7pFYwkiUl21R7/42By0+tkeCCiEOGXVc5MoMh8gG2YtODn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KEbBY7Gu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55TMALkm025217
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 07:30:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dbiU4WeJlxPr07x14qAPgklL7r+joI6II3iSXHyOuX8=; b=KEbBY7GuZgH86Cm9
	B0tnDbXpIXEPOQOavsMqYAKT6JVu9BQnI5lWecTZ8lVjKs8ewflbSMZBDhGKxcGq
	ezNDUUj0J4ebuj2SSxih2QYMBRfm8UibQvM0D9cFpmFMU5kKcYcjdU3mEEQdTuCP
	/nOGv5GQOfvun/kmj6ZGqs/P3C3YivlycmKzZ0LpTGDtIsKdLlymchT3n0TwnU7I
	cTofOHFJ2uqBVXTv0E+jxJGcofQxikWiuPNYEF7+MGHe4V5XijgzM6QEGqtjSu9x
	+DWEBBbqXUkFUFrjIdGeWv1u2IjJDoIhGLN3qBEKOocOL31euDBGRHliRogXwQ8Z
	kQGB+g==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47j8s9bq9r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 07:30:26 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6face45b58dso32433686d6.3
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 00:30:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751268625; x=1751873425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dbiU4WeJlxPr07x14qAPgklL7r+joI6II3iSXHyOuX8=;
        b=gsNFuaTh1JP6YhG27JrCCcnPPybPmZCn536DxXXDgVcvGAOXFlj86PQhSzA09gdlt/
         OUNeRnbpPiF2d39T4rCYMiDhl9uCV8w2cz+XWQr690nLkTw9SJR0Oq2BBILSohHiW9ul
         /W39WEHudHMpAeY1TtIUJq4muzSAs9BKEEgCpfl2UwUOXRbmbAO+dXmMHE6gTGQDhBFk
         BREhDJOLAAFMbl5MxJ3go3D2QkfQGGp367VV8TDzFod0IFRpWBATn0TCWm3HWqsbbazq
         KgFG0t3HiEYrqLBULCC/1i8NBFZ0extDAC+22DTH17haPPNJMSFvf29uXVnEafK0bMNG
         KxaA==
X-Forwarded-Encrypted: i=1; AJvYcCU5tpP/aphAuPSvr8ZrE71k4OZsIgFJVv9uyIfFJt/Q3eH+4tiotsOt57f/TT8orylyLGGS7Q0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQxNTKcZF0N5wD6wHpK4CMqxfFoUUeeN/jloBRj9Vz8pFy6O8r
	LR8+roLuhTQjIqNf4mU+k/2lO8V54QgwJbAem3zqXMaxEiiHomNvWap0rUb1z7iNGMEwUPkLjET
	LkA4jRnlip5VL8gCrlZNLJxZYYyBGOZwG7lPwaZuhqUesDhABuecbTOCsGewTJZy/kwPwRvc0Ez
	BNYYS5w9T2WdRE0r3OBhdw66CtqIc4Mfwskw==
X-Gm-Gg: ASbGncsiWc/6IxpsyezjkfcfIwzaoRcfSzrBJkHzJ+8oGjqbjDPl75M2mB4vyqWaKVz
	rG68eP/1e3aHlLlkfFmQQXGs4v94prIvXlygHu2OsZlvP00q/P789PJyTUywWFJeB3UtvQyo1Xq
	6ZanB/
X-Received: by 2002:a05:622a:144c:b0:476:95dd:520e with SMTP id d75a77b69052e-4a7fcac0b51mr202341121cf.16.1751268625480;
        Mon, 30 Jun 2025 00:30:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6U1CBAmzCpNigMlBWbP9zLpWdvxuVFoIPok+2G4N7Dxw18rxgwdwma8B/pYjZMexoPzVyDKklYgN3Uu2KeJE=
X-Received: by 2002:a05:622a:144c:b0:476:95dd:520e with SMTP id
 d75a77b69052e-4a7fcac0b51mr202340561cf.16.1751268625006; Mon, 30 Jun 2025
 00:30:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624213801.31702-1-ryazanov.s.a@gmail.com>
 <CAFEp6-08JX1gDDn2-hP5AjXHCGsPYHe05FscQoyiP_OaSQfzqQ@mail.gmail.com> <fc1f5d15-163c-49d7-ab94-90e0522b0e57@gmail.com>
In-Reply-To: <fc1f5d15-163c-49d7-ab94-90e0522b0e57@gmail.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 30 Jun 2025 09:30:14 +0200
X-Gm-Features: Ac12FXx5BYOM-yVp2ZpK01KHDHWSv79Wjk8GBosrNxsDB7eezvz5US1a5aVp2DU
Message-ID: <CAFEp6-1xoFW6xpQHPN4_XNtbjwvW=TUdFrOkFKwM+-rEH7WqMg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/6] net: wwan: add NMEA port type support
To: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        Eric Dumazet <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        netdev@vger.kernel.org, Slark Xiao <slark_xiao@163.com>,
        Muhammad Nuzaihan <zaihan@unrealasia.net>,
        Qiang Yu <quic_qianyu@quicinc.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Johan Hovold <johan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=H/Pbw/Yi c=1 sm=1 tr=0 ts=68623d12 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10
 a=pGLkceISAAAA:8 a=wfLqw5Yj37XQ_N0w6NkA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-ORIG-GUID: NKrjVLJ09YwL02A8hzYU02eXErkL4aiR
X-Proofpoint-GUID: NKrjVLJ09YwL02A8hzYU02eXErkL4aiR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDA2MSBTYWx0ZWRfX5xNlrPA+L9NS
 4xKrQ0MLFvnV434qqQFSQ5ofbvmz+dmrkPSOwpgz2Q7I8p07YxeKfzVEobTSELQEjAg3v8+lx7x
 u/hRv+rd880OGzN543QllRBWGFw4Fd9Wu3r2pp6A45pgN17r+bwrhSlfpCvCmj4EXCcL4qAj21t
 SLIo23JmFgPHc73TsaBWdL/yErGprjPGy6oTdg2MIDSNfiXrvwMt1NUw6Zgr3ISxXQV1rvFVzlV
 2/xcxKOqUdYvKLSiRK0TEtNBT4jQ30JnRUSik4A9ojkO6ndni3bGLpPOKWi2xoCetXlOJ5njqxn
 apI454t9OzsIyLhQwlC/HtYR0uPdNasLhyCHW0BmJ7NAbehJbLo1EsYF1iC9BTz0lKzFnPuJMZ4
 cVvawIFpqwVGKc9cKlluEEVffYpjqXJSyxd9nHMCpv5I5CK9a8AKBT4jh2jP2XE8ONk03h7V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 suspectscore=0 mlxlogscore=973
 priorityscore=1501 clxscore=1015 mlxscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 bulkscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506300061

Hi Sergey,


On Sun, Jun 29, 2025 at 12:07=E2=80=AFPM Sergey Ryazanov <ryazanov.s.a@gmai=
l.com> wrote:
>
> Hi Loic,
>
> On 6/29/25 05:50, Loic Poulain wrote:
> > Hi Sergey,
> >
> > On Tue, Jun 24, 2025 at 11:39=E2=80=AFPM Sergey Ryazanov <ryazanov.s.a@=
gmail.com> wrote:
> >> The series introduces a long discussed NMEA port type support for the
> >> WWAN subsystem. There are two goals. From the WWAN driver perspective,
> >> NMEA exported as any other port type (e.g. AT, MBIM, QMI, etc.). From
> >> user space software perspective, the exported chardev belongs to the
> >> GNSS class what makes it easy to distinguish desired port and the WWAN
> >> device common to both NMEA and control (AT, MBIM, etc.) ports makes it
> >> easy to locate a control port for the GNSS receiver activation.
> >>
> >> Done by exporting the NMEA port via the GNSS subsystem with the WWAN
> >> core acting as proxy between the WWAN modem driver and the GNSS
> >> subsystem.
> >>
> >> The series starts from a cleanup patch. Then two patches prepares the
> >> WWAN core for the proxy style operation. Followed by a patch introding=
 a
> >> new WWNA port type, integration with the GNSS subsystem and demux. The
> >> series ends with a couple of patches that introduce emulated EMEA port
> >> to the WWAN HW simulator.
> >>
> >> The series is the product of the discussion with Loic about the pros a=
nd
> >> cons of possible models and implementation. Also Muhammad and Slark di=
d
> >> a great job defining the problem, sharing the code and pushing me to
> >> finish the implementation. Many thanks.
> >>
> >> Comments are welcomed.
> >>
> >> Slark, Muhammad, if this series suits you, feel free to bundle it with
> >> the driver changes and (re-)send for final inclusion as a single serie=
s.
> >>
> >> Changes RFCv1->RFCv2:
> >> * Uniformly use put_device() to release port memory. This made code le=
ss
> >>    weird and way more clear. Thank you, Loic, for noticing and the fix
> >>    discussion!
> >
> > I think you can now send that series without the RFC tag. It looks good=
 to me.
>
> Thank you for reviewing it. Do you think it makes sense to introduce new
> API without an actual user? Ok, we have two drivers potentially ready to
> use GNSS port type, but they are not yet here. That is why I have send
> as RFC. On another hand, testing with simulator has not revealed any
> issue and GNSS port type implementation looks ready to be merged.

Right, we need a proper user for it, I think some MHI PCIe modems already
have this NMEA port available, so it can easily be added to this PR. For su=
re
we will need someone to test this.

> Let's wait a month or so and if no actual driver patch going to be send,
> then I will resend as formal patch to have the functionality in the
> kernel in advance.

ack.

Regards,
Loic

