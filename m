Return-Path: <netdev+bounces-98111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8638CF6FB
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 02:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D707D28174D
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 00:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719EF6FCB;
	Mon, 27 May 2024 00:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=orange.com header.i=@orange.com header.b="GA0pocAe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out.orange.com (smtp-out.orange.com [80.12.126.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C766B6FB0;
	Mon, 27 May 2024 00:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.126.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716769181; cv=none; b=soxg8xa860dajiHnMs3/pYkgoJyxtght1XfbSpndyCwP0L5bj78hEEUq42c1v9ZT74r9xKP7g9hNv4uQw9QM/VYemjukjR6hX7dvNcIJHYPZT5xjlBInemSVo8pW1TTEsbq1v7azeZ8B9XaIjI56wYpRGDJ/jGBMCHaM1OcIufo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716769181; c=relaxed/simple;
	bh=8c4ilwGABuwhx4/FiUe+6pqox6IKYVl2IVng+0WGpvg=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=UzLjWT+aMRrUBimfydSsqSurYc+dWwAmXIgqaBopGS8fU/wIdrJ19uxVV3ZrZspzj4EBtbS3jXl6ncKoQrEo09Vvy8yjqm4CBWStq9c7NoNw1RPE6ans1v8IkxwgGyqhLEzPdJmUqjMs18zi19Ut1uVrBWc7ENgalSTocFt6A/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=orange.com; spf=pass smtp.mailfrom=orange.com; dkim=pass (2048-bit key) header.d=orange.com header.i=@orange.com header.b=GA0pocAe; arc=none smtp.client-ip=80.12.126.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=orange.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=orange.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=orange.com; i=@orange.com; q=dns/txt; s=orange002;
  t=1716769178; x=1748305178;
  h=message-id:date:mime-version:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:from;
  bh=8c4ilwGABuwhx4/FiUe+6pqox6IKYVl2IVng+0WGpvg=;
  b=GA0pocAerad0U6VlOW0t03iBjE1L0XKAh0UUZHD+4NrC/tD9OXuaUOl2
   q4ACfEDwWyobQC4FkMfnDBESe7H4qpmpsJYLI0R9GFK5SWOJ8PgmCr+d7
   u1bnN7gKx9AQgALz6uQMwytxTqDv1Fk5128vTql+qtV7dI1WJD6m264Ka
   OJXYFCnrRT3+f+QApwf3Hc+EGKvc1x5a1BFNhrAbxknFGLgDV0AoBz+Fb
   CxPDEkiJoGgd6L3KCBx8bpKMML1s3sxpGe9prE6LsE4LDUHBXuz90Md+p
   Ml6/zDT6B/gtH2jD0xsO8HzyabvAr/9CxesVJ4c+fmqxji9kjEj+6TjeW
   Q==;
Received: from unknown (HELO opfedv1rlp0e.nor.fr.ftgroup) ([x.x.x.x]) by
 smtp-out.orange.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2024 02:18:26 +0200
Received: from mailhost.rd.francetelecom.fr (HELO l-mail-int) ([x.x.x.x]) by
 opfedv1rlp0e.nor.fr.ftgroup with ESMTP; 27 May 2024 02:18:28 +0200
Received: from lat6466.rd.francetelecom.fr ([x.x.x.x])	by l-mail-int with esmtp (Exim
 4.94.2)	(envelope-from <alexandre.ferrieux@orange.com>)	id 1sBO49-009Ocm-Gi;
 Mon, 27 May 2024 02:18:26 +0200
From: alexandre.ferrieux@orange.com
X-IronPort-AV: E=Sophos;i="6.08,191,1712613600"; 
   d="scan'208";a="145223146"
Message-ID: <5bbaf136-5409-4256-b4a4-1ac8ba501b26@orange.com>
Date: Mon, 27 May 2024 02:18:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH] af_packet: Handle outgoing VLAN packets without hardware
 offloading
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Chengen Du <chengen.du@canonical.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240520070348.26725-1-chengen.du@canonical.com>
 <664f5938d2bef_1b5d2429467@willemb.c.googlers.com.notmuch>
 <CAPza5qc+m6aK0hOn8m1OxnmNVibJQn-VFXBAnjrca+UrcmEW4g@mail.gmail.com>
 <66520906120ae_215a8029466@willemb.c.googlers.com.notmuch>
 <3acef339-cdeb-407c-b643-0481bfbe3c80@orange.com>
 <6653547768757_23ef3529455@willemb.c.googlers.com.notmuch>
Content-Language: fr, en-US
In-Reply-To: <6653547768757_23ef3529455@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

T24gMjYvMDUvMjAyNCAxNzoyNSwgV2lsbGVtIGRlIEJydWlqbiB3cm90ZToKPiBJIGRvbid0IHRo
aW5rIGEgbmV3IERMVF9MSU5VWF9TTEwzIGlzIGEgc29sdXRpb24uIFRoZSBhcHBsaWNhdGlvbgo+
IGp1c3Qgd2FudHMgdG8gcmVjZWl2ZSB0aGUgZnVsbCBMMi41IGhlYWRlciwgbm90IHlldCBhbm90
aGVyIHBhcnNlZAo+IHZlcnNpb24KClllcywgSSBkaWQgbm90IGludGVuZCBhbnkgcGFyc2luZyBl
aXRoZXI6IHRoZSBTTEx2eCBzaG91bGQgZW5kIHdpdGggdGhlIGV0aHR5cGUgCih0aGUgb25lIHRo
YXQgb2NjdXJzIHJpZ2h0IGFmdGVyIHRoZSBNQUMgYWRkcmVzc2VzIGluIEV0aGVybmV0KS4gQnV0
IEkgd2FzIGp1c3QgCnBvaW50aW5nIG91dCB0aGF0IGl0IGlzIGEgcGl0eSB0aGF0IFNTTHYxIGFu
ZCBTU0x2MiBvbmx5IGtlZXAgdGhlIHNvdXJjZSBNQUMgCmFkZHJlc3Mgd2hlbiBhbGwgcGh5c2lj
YWwgaW50ZXJmYWNlcyBpbiBhIHN5c3RlbSBhcmUgRXRoZXJuZXQuIFdoeSBub3Qga2VlcCB0aGUg
Cndob2xlIE1BQyBoZWFkZXIgPwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18NCkNlIG1lc3NhZ2UgZXQgc2VzIHBpZWNlcyBqb2ludGVzIHBldXZlbnQg
Y29udGVuaXIgZGVzIGluZm9ybWF0aW9ucyBjb25maWRlbnRpZWxsZXMgb3UgcHJpdmlsZWdpZWVz
IGV0IG5lIGRvaXZlbnQgZG9uYw0KcGFzIGV0cmUgZGlmZnVzZXMsIGV4cGxvaXRlcyBvdSBjb3Bp
ZXMgc2FucyBhdXRvcmlzYXRpb24uIFNpIHZvdXMgYXZleiByZWN1IGNlIG1lc3NhZ2UgcGFyIGVy
cmV1ciwgdmV1aWxsZXogbGUgc2lnbmFsZXINCmEgbCdleHBlZGl0ZXVyIGV0IGxlIGRldHJ1aXJl
IGFpbnNpIHF1ZSBsZXMgcGllY2VzIGpvaW50ZXMuIExlcyBtZXNzYWdlcyBlbGVjdHJvbmlxdWVz
IGV0YW50IHN1c2NlcHRpYmxlcyBkJ2FsdGVyYXRpb24sDQpPcmFuZ2UgZGVjbGluZSB0b3V0ZSBy
ZXNwb25zYWJpbGl0ZSBzaSBjZSBtZXNzYWdlIGEgZXRlIGFsdGVyZSwgZGVmb3JtZSBvdSBmYWxz
aWZpZS4gTWVyY2kuDQoNClRoaXMgbWVzc2FnZSBhbmQgaXRzIGF0dGFjaG1lbnRzIG1heSBjb250
YWluIGNvbmZpZGVudGlhbCBvciBwcml2aWxlZ2VkIGluZm9ybWF0aW9uIHRoYXQgbWF5IGJlIHBy
b3RlY3RlZCBieSBsYXc7DQp0aGV5IHNob3VsZCBub3QgYmUgZGlzdHJpYnV0ZWQsIHVzZWQgb3Ig
Y29waWVkIHdpdGhvdXQgYXV0aG9yaXNhdGlvbi4NCklmIHlvdSBoYXZlIHJlY2VpdmVkIHRoaXMg
ZW1haWwgaW4gZXJyb3IsIHBsZWFzZSBub3RpZnkgdGhlIHNlbmRlciBhbmQgZGVsZXRlIHRoaXMg
bWVzc2FnZSBhbmQgaXRzIGF0dGFjaG1lbnRzLg0KQXMgZW1haWxzIG1heSBiZSBhbHRlcmVkLCBP
cmFuZ2UgaXMgbm90IGxpYWJsZSBmb3IgbWVzc2FnZXMgdGhhdCBoYXZlIGJlZW4gbW9kaWZpZWQs
IGNoYW5nZWQgb3IgZmFsc2lmaWVkLg0KVGhhbmsgeW91Lgo=


