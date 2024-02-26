Return-Path: <netdev+bounces-74888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D188672E7
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 12:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86A85B22802
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 11:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A44C1B966;
	Mon, 26 Feb 2024 11:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="dQAhni/v"
X-Original-To: netdev@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AED22337
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 11:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708945573; cv=none; b=mqn8sphenbuPcohSOHwqEuVbIq9y4ryNKSDhLe3Ibdke/NCs56/XS4QZ2TZFAxjIoJQTVLFp0/0HAPL5Z9SltkMae2nngSW+TI4/0ge1ANm/WO5WUMXeB9JdAwKe2n07x7Ye2K/kaXgBzVXzNubBHw+IAMXaw2OHarbG6yGUoAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708945573; c=relaxed/simple;
	bh=txjSI9YvbXOueA/gw1C6cjhGaULHzcTbITnNwKmefRE=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=i6hbZl6BSbRnjFGo7IjW8ktihligMHJ9HezRXsEhCoqAX8wou9Zu90/h2gN5Dj9UdyAYedRVNj04/I0UM4hZk/uTcjo+kTk/v0Q71beLsSRAVjOKY75AZPDgDUXex44IOmKhxQOTQoa8n48QRjD5Ha5smNsR/0E3ey5nOsIotNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=dQAhni/v; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240226110608euoutp0291584825a5111c8c574eb3936905bd7c~3ZPCXkEdY0446204462euoutp02o
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 11:06:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240226110608euoutp0291584825a5111c8c574eb3936905bd7c~3ZPCXkEdY0446204462euoutp02o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1708945568;
	bh=Oal09ypwQKRjD1RaJBe+H8ZWaOazr1QWSEpDTUf5M1Y=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=dQAhni/vwO6eBFRdJyIZbwzGpIpp9wv2sjXH74CbG9uZ0NdSQb/gdNTe98n55btBU
	 zilBA7zFrU90Q70mVr1sColh7rW6CU5KaNYi2dL8Tn5fPcsuOUKFFInBkGEEd0Pf4/
	 MjxNsFm1tHqc9/4+xTJOxU5GhdqjskaNwFQ0eQQA=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240226110607eucas1p1c163aefbb5dc01ad22bd90c87abd0da1~3ZPCPlfDa1395113951eucas1p1D;
	Mon, 26 Feb 2024 11:06:07 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id A1.9E.09539.F907CD56; Mon, 26
	Feb 2024 11:06:07 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240226110607eucas1p1a08547460831ecd5cf3b7b16abc1f21b~3ZPBzL7461395113951eucas1p1C;
	Mon, 26 Feb 2024 11:06:07 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240226110607eusmtrp2281c2e25524ddbc6c109eafe984b52b7~3ZPByjzZF1723817238eusmtrp2O;
	Mon, 26 Feb 2024 11:06:07 +0000 (GMT)
X-AuditID: cbfec7f2-52bff70000002543-19-65dc709f7a7a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id A4.CD.10702.F907CD56; Mon, 26
	Feb 2024 11:06:07 +0000 (GMT)
Received: from AMDN5484 (unknown [106.210.136.187]) by eusmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20240226110607eusmtip24e3db24480bfb1f1abdcb34629f95f4e~3ZPBbJoC11569115691eusmtip2E;
	Mon, 26 Feb 2024 11:06:07 +0000 (GMT)
From: "Jakub Raczynski" <j.raczynski@samsung.com>
To: "'Jakub Kicinski'" <kuba@kernel.org>
Cc: <netdev@vger.kernel.org>, <alexandre.torgue@foss.st.com>,
	<joabreu@synopsys.com>
In-Reply-To: <20240223163251.49bd1870@kernel.org>
Subject: RE: [PATCH] stmmac: Clear variable when destroying workqueue
Date: Mon, 26 Feb 2024 12:06:02 +0100
Message-ID: <000001da68a3$cc05a190$6410e4b0$@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKcc4drKQoUXOtC3cZrasrnYh3YrQJs7JlSAaivsr6vd7GtcA==
Content-Language: pl
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplleLIzCtJLcpLzFFi42LZduznOd35BXdSDY7+MbX4+XIao8W9Re9Y
	LS5s62O1OLZAzIHF42n/VnaPTas62Ty27P/M6PF5k1wASxSXTUpqTmZZapG+XQJXxuT1qxgL
	pnJXPLuxnLGBcQ5nFyMnh4SAicTPG4cZuxi5OIQEVjBK7Jq0iRnC+cIo8fvkYVaQKiGBz4wS
	l3aXw3RsmfoFqmM5o8SMf3OgOl4wSmy9NZsdpIpNwFBi0pZlLCC2iICGxL5Z8xhBbGaBMImF
	bc1gNZxANWeOfmUDsYUFXCX+vv7PBGKzCKhKfFx/jxnE5hWwlFh4tY0FwhaUODnzCQvEHHmJ
	7W/nMENcpCDx8+kyVohdThLv9kDcwCwgInHjUQvYpRICZzgkprXMhWpwkVg+4yw7hC0s8er4
	FihbRuL/zvlMEHa9xMUDh6DsHkaJcz+NIGxrib0HrgAt4wBaoCmxfpc+iCkh4CixdLozhMkn
	ceOtIMQFfBKTtk1nhgjzSnS0CUGYqhJtP8QnMCrPQvLWLCRvzUJy/iyETQsYWVYxiqeWFuem
	pxYb5qWW6xUn5haX5qXrJefnbmIEppTT/45/2sE499VHvUOMTByMhxglOJiVRHjDZW6mCvGm
	JFZWpRblxxeV5qQWH2KU5mBREudVTZFPFRJITyxJzU5NLUgtgskycXBKNTDxT1tuqOotKhlX
	OKe1pVS9wvlS2gv+3ZffhzxgbGZRu3ytfZ1cnLKToWpq3mWjO9WFbAtEBXbsW8N7UCbw3Akj
	s6M98ipOF5Yy+vTfnKJ6zlt9lmGpyJt9vqzbHBjmzf4wz1j2mN17zvBDKx7NYlZq/BLed/bk
	tCN7FJakHpwzKSuKtWCimlqQbNceg70y974KPr2RunbB2otulSnKs9nrN3/e9OXX3YDwK/tk
	eSdnSBiK+/NUpE9wz9zy69+3klNvJtv0dFUEVapfD2j6fiTrTBp3esbxzNLdD/1UOKVLZQ82
	iBa0vOSPji6yurOyMGOh75HSp0IvbXnmrjXe02nEJ/GhuGjy8ekuMfN7GpVYijMSDbWYi4oT
	ATQ6rguYAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCIsWRmVeSWpSXmKPExsVy+t/xe7rzC+6kGuzsl7D4+XIao8W9Re9Y
	LS5s62O1OLZAzIHF42n/VnaPTas62Ty27P/M6PF5k1wAS5SeTVF+aUmqQkZ+cYmtUrShhZGe
	oaWFnpGJpZ6hsXmslZGpkr6dTUpqTmZZapG+XYJexuT1qxgLpnJXPLuxnLGBcQ5nFyMnh4SA
	icSWqV8Yuxi5OIQEljJKdGx8xtzFyAGUkJaYuCUIokZY4s+1LjYQW0jgGaPEjGUqIDabgKHE
	pC3LWEBsEQENiX2z5jGC2MwCERKvr01kg5i5mVFi+7K7TCAJTqCGM0e/gg0SFnCV+Pv6P1ic
	RUBV4uP6e8wgNq+ApcTCq20sELagxMmZT1hA7mEW0JNo2wg1X15i+9s5zBC3KUj8fLqMFeIG
	J4l3e2azQ9SISNx41MI4gVF4FpJJsxAmzUIyaRaSjgWMLKsYRVJLi3PTc4uN9IoTc4tL89L1
	kvNzNzECo2vbsZ9bdjCufPVR7xAjEwfjIUYJDmYlEd5wmZupQrwpiZVVqUX58UWlOanFhxhN
	gT6byCwlmpwPjO+8knhDMwNTQxMzSwNTSzNjJXFez4KORCGB9MSS1OzU1ILUIpg+Jg5OqQam
	IPOdLtIZOyRVI70YmA7uUYq50BDuXdpcNWGn6HphpkU3n5c3tu5kixPxfyRiHZyRev/s7A0i
	znNbj52unsx03eKylqsZi7TbnP+yOfH73hQ61PiZ161Z4r7m9t2PKuoCbMF5JjO0OtedO/vT
	O1tn1qOVjTL7tRcs/npDYOfPtwEeEtM/fmk/rybUtWL5TLlLLn80/S5pacmpRM9rYFUzmJv7
	dm7pygchht0/L09n7ihifz7nX9LtL+qNRiyXbz65PJ/roZjWgqmvrhmemPJ1Sxh/So+p0J5P
	n6Z80rd2zmHueL/k9s6KXTPtDLe/UHrXXOs54UKuoE7HAumNN53Vvl889Wr5dSa9re+iilMr
	lViKMxINtZiLihMB/PncPDcDAAA=
X-CMS-MailID: 20240226110607eucas1p1a08547460831ecd5cf3b7b16abc1f21b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240221143239eucas1p259ca215d24490cd7fc073a6c3c35693b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240221143239eucas1p259ca215d24490cd7fc073a6c3c35693b
References: <CGME20240221143239eucas1p259ca215d24490cd7fc073a6c3c35693b@eucas1p2.samsung.com>
	<20240221143233.54350-1-j.raczynski@samsung.com>
	<20240223163251.49bd1870@kernel.org>


On Wed, 21 Feb 2024 15:32:33 +0100 Jakub Raczynski wrote:
>> Currently when suspending driver and stopping workqueue it is checked 
>> whether workqueue is not NULL and if so, it is destroyed.
>> Function destroy_workqueue() does drain queue and does clear variable, 
>> but it does not set workqueue variable to NULL. This can cause 
>> kernel/module panic if code attempts to clear workqueue that was not
initialized.

> Adding __FPE_REMOVING for allocation, it would be something, but failure
here is less that likely. DMA engine start can happen since some Synopsys IP
have specific clock timing requirements for
> DMA, which sometimes must be provided by another driver (if for example
PHY is driven by GPIO or PHY uses low-power mode during suspend).
> As for queued work, you are right, additional check for __FPE_REMOVING and
NULL check should be added to stmmac_service_event_schedule(), as is in
stmmac_fpe_event_status().
> Will re-test that and resend patch as requested.

Scratch that, confused main workqueue with fpe_workqueue in that message.
Proposed commit should not introduce problem with fpe_workqueue, since in
stmmac_fpe_event_status() there is check for both NULL and __FPE_REMOVING
before queueing work.
Will re-check if there are additional calls before submitting commit.

As for the addition of __FPE_REMOVING to initialization fail, would prefer
that in different commit.


