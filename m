Return-Path: <netdev+bounces-177304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F44A6ED59
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 11:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8917716FD01
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 10:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D691DE4EC;
	Tue, 25 Mar 2025 10:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=avride-ai.20230601.gappssmtp.com header.i=@avride-ai.20230601.gappssmtp.com header.b="13Kt8ifF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DF81A23AA
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 10:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742897607; cv=none; b=JdTKhGvd+wy+MAQquMBlJRcxL5gzBzck8gbRkMbnFCDGwzT7ttU4e/Bftinn01vu1l7KEw+kEDRTFlxwvI/LAHCRFM/PpCQScdbGJ5Rj0VoIgxP3XjrSVlrrPJeU5zvvWOyvxDOAkY/vFw1quzxSD/errjBh7o06qVQa/lFv2xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742897607; c=relaxed/simple;
	bh=TOU9ArfUSXBdqA7/yhv8iMaeUWmJDBAcmhdZT0GLyAo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Xf9umn3FtEU7TyUzsTnCcEDgdU+GW4dmUwbHzaTFP57MPejKfqGqTaSY9lhK7KNuHwzXsbV2Dd51jLF07F1KQVI43Zfq0A7q0JH8JIcSsHH7+Qp5lF7f3jLR7yFcIp/rH6s4tQY3aA9OYsUVNy0HCoUm5snvjG9uIOI6B+xeqRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=avride.ai; spf=none smtp.mailfrom=avride.ai; dkim=pass (2048-bit key) header.d=avride-ai.20230601.gappssmtp.com header.i=@avride-ai.20230601.gappssmtp.com header.b=13Kt8ifF; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=avride.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=avride.ai
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-39ac8e7688aso351400f8f.2
        for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 03:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=avride-ai.20230601.gappssmtp.com; s=20230601; t=1742897603; x=1743502403; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9bZvYVE6bOz/DEZhMQaP2IpbWcvlfvs2hG6XIMnsgdA=;
        b=13Kt8ifF/U+s50CtGH3Cbunizr5xcFqCOdCInCpGtSbGgyp7Wbkv7mLVP5Of5S5Rxg
         fjuJ/oMnERjBJYRPKk57GhBnBP31ldtDVyvz5WzfmgBbxTCu8otS2bBcR82vTD6pt/T1
         cCxEXqlYtLis/1UlhhiRMN4Vo75p4VOomHi2PM1Ic6c5bU6BRESbhJrzUBTCCGmCUD2u
         hyLElgFUeUs6J7KdjVPU/3MKtc882EEfbomIZCH0+oDB21Ok+WIkkvnhGYBcUpK6PX6h
         V3mz+jdqEg+Ftp3TwRx+PtcdDAl5+uXgqYyNnr3JI6PHLAM9a3+hMRQn5e1FLTU8FfBY
         iWwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742897603; x=1743502403;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9bZvYVE6bOz/DEZhMQaP2IpbWcvlfvs2hG6XIMnsgdA=;
        b=lvKGgYW+m28guTgJj4zGAG+vMJ8Wckbrux1egjKnhal0lCfMFP0DWDe8HjPjUYShjD
         GbwX5+5tmRjUXLPiEqLpftpN2p30oPmzGH0XXADO4dqAl8Q4oOeiwj06rKuEAiJGsaSD
         1/8EypOFTttrb/ngOyv4TJk3RY/fU01Da3Ery4w3b/f2mvTMLDnQ206IR/ydXW9ftxCB
         JRJ0M3AbQRVAMV03/dX2SfQU29BJqYMxYfomA8fqJWDYx1sFaZzO/5WV8Nx1uNxIzN3F
         CQHbyk75f1YlkiXoYemsn4uGZOqfkN7LQinR9LimIFr7kaZ7DZ001MwccypVeDHjyR3c
         zSpg==
X-Forwarded-Encrypted: i=1; AJvYcCWl1y74795d5RHX3B1ztCmFYy5DX1sCkwu9N8PzG2nD7xsp5GXLWtf4ZbslTYJg4zw9Ed1eaBY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9pSejGMjGHSd8Bzv8/HLGlfGV+mj8EmRqQgSLyxAvpueeMcYe
	IZzKj+1tRSIXMAVHr6Ac/oyN0vT0z5q8+stk3v34fSUmqqxWxMX0rSA59jqwP5w=
X-Gm-Gg: ASbGncuUjpaONxyskSaRTcN9Jci4yvN/LxllFmxvpPnn6NMaCgIlK2ZndXI7xKkieWd
	1Q+yO1oIJF4QSPlOb1ghsBsLDknCZUAmUMLkfg3WS9ORWUtkRsPiTyJzk3jr3nQtjDclSOil44r
	c/9jIInboo7c2MHg5ZiwSh8DyVW8eK7va7sCcBJtNFFb2nikx2jQ1fo0fQJgeB5boCyjrvFJFir
	AaH0M6kyrYlbCFEQg9KeznX4j4bV46RqpoRVAj27y59Qd/ghThrJN2/V7Yjgj1u7S5gBXS3Kthh
	1kwYAhYrlN2mE5akVf1f3fxFZWBRH0zE6ydq42qeEIbBRpiQcFkpbY8XUs/Bgp2VQ4jR05+l8A=
	=
X-Google-Smtp-Source: AGHT+IFy6Qag+LI/mRJxsorJ10YGv3ZfVWvD6eCNMn5tVPk3l26VqyPpw1xJfcW92zo76w3CB539TA==
X-Received: by 2002:a05:6000:2808:b0:39a:c9d9:84d2 with SMTP id ffacd0b85a97d-39ac9d98556mr668673f8f.46.1742897603387;
        Tue, 25 Mar 2025 03:13:23 -0700 (PDT)
Received: from smtpclient.apple ([2a02:14a:105:a03:98e8:80f1:5c82:4808])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d6ddf2974sm11367695e9.0.2025.03.25.03.13.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Mar 2025 03:13:22 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: bnxt_en: Incorrect tx timestamp report
From: Kamil Zaripov <zaripov-kamil@avride.ai>
In-Reply-To: <CALs4sv1H=rS96Jq_4i=S0kL57uR6v-sEKbZcqm2VgY6UXbVeMA@mail.gmail.com>
Date: Tue, 25 Mar 2025 12:13:11 +0200
Cc: Michael Chan <michael.chan@broadcom.com>,
 Jacob Keller <jacob.e.keller@intel.com>,
 Linux Netdev List <netdev@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9200948E-51F9-45A4-A04C-8AD0C749AD7B@avride.ai>
References: <DE1DD9A1-3BB2-4AFB-AE3B-9389D3054875@avride.ai>
 <8f128d86-a39c-4699-800a-67084671e853@intel.com>
 <CAGtf3iaO+Q=He7xyCCfzfPQDH_dHYYG1rHbpaUe-oBo90JBtjA@mail.gmail.com>
 <CACKFLinG2s5HVisa7YoWAZByty0AyCqO-gixAE8FSwVHKK8cjQ@mail.gmail.com>
 <CALs4sv1H=rS96Jq_4i=S0kL57uR6v-sEKbZcqm2VgY6UXbVeMA@mail.gmail.com>
To: Pavan Chebbi <pavan.chebbi@broadcom.com>
X-Mailer: Apple Mail (2.3774.600.62)


> On 24 Mar 2025, at 17:04, Pavan Chebbi <pavan.chebbi@broadcom.com> =
wrote:
>=20
>> On Fri, 21 Mar, 2025, 11:03=E2=80=AFpm Michael Chan, =
<michael.chan@broadcom.com> wrote:
>>=20
>> > On Fri, Mar 21, 2025 at 8:17=E2=80=AFAM Kamil Zaripov =
<zaripov-kamil@avride.ai> wrote:
>> >
>> > > That depends. If it has only one underlying clock, but each PF =
has its
>> > > own register space, it may functionally be independent clocks in
>> > > practice. I don't know the bnxt_en driver or hardware well enough =
to
>> > > know if that is the case.
>> >
>> > > If it really is one clock with one set of registers to control =
it, then
>> > > it should only expose one PHC. This may be tricky depending on =
the
>> > > driver design. (See ice as an example where we've had a lot of
>> > > challenges in this space because of the multiple PFs)
>> >
>> > I can only guess, from looking at the __bnxt_hwrm_ptp_qcfg =
function,
>> > that it depends on hardware and/or firmware (see
>> > =
https://elixir.bootlin.com/linux/v6.13.7/source/drivers/net/ethernet/broad=
com/bnxt/bnxt.c#L9427-L9431).
>> > I hope that broadcom folks can clarify this.
>> >
>>=20
>> It is one physical PHC per chip.  Each function has access to the
>> shared PHC.   It won't work properly when multiple functions try to
>> adjust the PHC independently.  That's why we use the non-RTC mode =
when
>> the PHC is shared in multi-function mode.  Pavan can add more details
>> on this.
> Yes, that's correct. It's one PHC shared across functions. The way we =
handle multiple
> functions accessing the shared PHC is by firmware allowing only one =
function to adjust
> the frequency. All the other functions' adjustments are ignored. ...

I guess I don=E2=80=99t understand how does it work. Am I right that if =
userspace program changes frequency of PHC devices 0,1,2,3 (one for each =
port present in NIC) driver will send PHC frequency change 4 times but =
firmware will drop 3 of these frequency change commands and will pick up =
only one? How can I understand which PHC will actually represent =
adjustable clock and which one is phony?

Another thing that I cannot understand is so-called RTC and non-RTC =
mode. Is there any documentation that describes it? Or specific parts of =
the driver that change its behavior on for RTC and non-RTC mode?

> =E2=80=A6 However, needless to say,
> they all still receive the latest timestamps. As I recall, this event =
design was an earlier
> version of our multi host support implementation where the rollover =
was being tracked in
> the firmware.=20

=46rom which version the bnxt_en driver starts to track rollover on the =
driver side rather than firmware side?

> The latest driver handles the rollover on its own and we don't need =
the firmware to tell us.
> I checked with the firmware team and I gather that the version you are =
using is very old.=20
> Firmware version 230.x onwards, you should not receive this event for =
rollovers.
> Is it possible for you to update the firmware? Do you have access to a =
more recent (230+) firmware?

Yes, I can update firmware if you can tell where can I find the latest =
firmware and the update instructions?


