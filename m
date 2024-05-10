Return-Path: <netdev+bounces-95491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0048C266F
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 16:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D13FB20D6A
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 14:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F8912C80F;
	Fri, 10 May 2024 14:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ilz8RyAg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442C712C49A
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 14:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715350246; cv=none; b=UbaPgDCGTk937vu4EuAfdNH7qMjVdPfDV5BKW/cmSBf8tGITpdeamNWcDbJeT6vV6OoJi/t5QT5WJOuIwzpDgV6wLnEDD2+kffLwZ2ychrxwzdAEo51BIeM3Jvcj6f75S4afKDDHNAWGDQerfKTOQwXc9E4bf69ln9ProbYMFb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715350246; c=relaxed/simple;
	bh=P7wLA221wOQc0FUzXpBlMj/IefiGi8h0l+wtul9S6Uo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=tnRXVGlcXT4+M8S9ib/9ax+Y4Hc3JcWNRce9m88d3jhLO9SmPaZDmS0OxTZKzYB0AicIdjLKEHU7wK6NWbmGH+1SFTwIWy0LBN8WAtghwDSgj9qx8xp1uEv4bWMzQyesrW1KqPOR8zJLapqAzxxEuyQsDPyOxTle0USdlRf0q+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ilz8RyAg; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a59ad344f7dso440386666b.0
        for <netdev@vger.kernel.org>; Fri, 10 May 2024 07:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715350243; x=1715955043; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P7wLA221wOQc0FUzXpBlMj/IefiGi8h0l+wtul9S6Uo=;
        b=ilz8RyAg6tWGESnTrq70B8BR11CmMZuLSttcte+YoLn6GQP8QsMtVRRPor3IDpEHi8
         vycKjw1J5DcgsgT54Ohp+XFBovw0O9kgyTb9dViGa6WbOM5i6EERV8KOiHRFYyxuO5TT
         cfaUoduxxPeFvrln4LuyE7V464RQBTlQbVmc+df5Sik3F2byAaFZlKVgbeRWeYz7O4b6
         FaxcEfts0FAHBcEKvzWGWuIuG+A8jQcJr13hRf4ukbwCgFVE1hnUvQ3ldHZEWI382D7+
         6wE/xfpYIaqClL6SGbUXKh1ZIPmMwdq+EfPDxQrYetABV2hagelMXXTJN5Lj4Rh7jCEh
         QjHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715350243; x=1715955043;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P7wLA221wOQc0FUzXpBlMj/IefiGi8h0l+wtul9S6Uo=;
        b=n9dNgSffgn2GMfqM+1msW4/N06aw3qBGuSN9WBkEwY+e8YVBr6U9e/l6D8QfLoUqso
         2jqK7PbTmi1S2NTFv1+LSECKSwXZynK6VFPyHBrNPG1C2gjlIW+bDQ3pSKYAg/bbqZDA
         x4z/i15h4GaVfL2VVxck3iFIap+lYWrJRYywpybiZLS0XxR1ZiQscjOBuMz49zk8TL5g
         Xi6h3IUHMo91WOc7B8pCyZ8jtVWa98amqdIRdCC+W/muYftaC8vLV7kVBVdrvAeXgvGL
         hi6fPWg1aplJZyA+BqO1P/9pmR8iimWlpwfbgqoU90nQtk4rckeA+Ub9Bw20bBurBqB+
         U4CQ==
X-Gm-Message-State: AOJu0YzS6C0SW83l0QAhikZRFOC9UohfobuFvNyTk6tQkeNzwPkhdB3y
	WJYn2gzhRf5Okp/SQTqO6iIl3uqGEaivhq1AC3iUghmfbp5ULjFvwrL4llFBYEWfHxNgVHPABgT
	+dKa8IuMrJoihag+Y5gtIKJ0nk0zaZQ==
X-Google-Smtp-Source: AGHT+IFzSlaaX4t4P2EyVGn2niGMMmznuEV/+yqCQ620vAIzDJudxfxjSgC6+vIsrZmLMKK4S1ShEVsGwAgSZ5gmhTo=
X-Received: by 2002:a17:906:1914:b0:a5a:3af7:9d37 with SMTP id
 a640c23a62f3a-a5a3af79e69mr77391266b.60.1715350243173; Fri, 10 May 2024
 07:10:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: James Dutton <james.dutton@gmail.com>
Date: Fri, 10 May 2024 15:10:06 +0100
Message-ID: <CAAMvbhHpj+HzmxnGfj_dKFq6nmnAr2C9v__1Ptkd19bnPCxd1w@mail.gmail.com>
Subject: SFP and SFP+
To: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

Linux kernel handling of SFP and SFP+ Ethernet transceivers does not
seem to be very reliable.
I.e. Very few SFP / SFP+ transceivers actually work in Linux, even if
they work in a COTS network switch.
For example, there are more and more Wireless access points appearing
with SFP/SFP+ ports and run the Linux kernel.
I think the main stumbling point is that the SFP/SFP+ quirks are based
on the Name fields of the transceiver.
I have seen two different SFP+ transceivers with exactly the same
name, one supporting ROLLBALL and C46 and one supporting neither.
Maybe it would be more reliable if one first assumed that the SFP does
not do negotiation, C22, C46, ROLLBALL protocols and instead only
reports link up / link down. One then implements methods to detect
whether the transceiver does anything more feature rich, such as
support for C22, C46 or ROLLBALL and if so, then uses those also.
It seems like a majority of the problem ones are the ones that have
one rate for the SERDES and another rate for the Link itself, with the
transceiver doing rate adaption. This is most common for the RJ45
SFP/SFP+ transceivers in the 10/100/1000/10000 speed range.
It might also be helpful to report with ethtool the PHY Link rate as
well as the SERDES rate and also report the link status of the PHY
Link and SERDES link separately.

What is the view of people more expert than me on this list?

Kind Regards

James

