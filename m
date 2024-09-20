Return-Path: <netdev+bounces-129092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D748797D67A
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 15:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15C191C21168
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 13:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456A217A5BE;
	Fri, 20 Sep 2024 13:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YCvpEre+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68FD3BBC1;
	Fri, 20 Sep 2024 13:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726840437; cv=none; b=LLYE5vwImpNwHqYIpUI+tTYQOTZGQLF7Ys4Oa1tP9o85cQpBaoqGD3AnpBsRDbpuPHVdHJa3Ri4EPztfmqMPWHk3MzjuP5/wMe49QYsp+QIix/OJIV2Gr7arCQi04yJSDde8GCSpqlAMdtqma2XWnk+CpBElU1nao7n/6IGrf34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726840437; c=relaxed/simple;
	bh=9H+NTeNPvd+4QlpymzpekwJLXBRPMnbrJztLURvIkic=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=MRvcLURNxgceMUCDltawCEFXvxMKHp8KOGNGuY3XKK/03A8HqzggTg5vfSfGXTAPYdd6hnyItCoTkM/6ygh6zxcMvJxFGnTqWyJagz/4whTfHvXqn+m6nGpgkumuq/FiT38zCBKPJ2xc9mC8B9CZ+kWXUQVj8WeNDSj282VcqbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YCvpEre+; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2059112f0a7so19739725ad.3;
        Fri, 20 Sep 2024 06:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726840435; x=1727445235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9H+NTeNPvd+4QlpymzpekwJLXBRPMnbrJztLURvIkic=;
        b=YCvpEre+megPB01NiqO5lNksK0zi/ZtPS4ShYBKSZxcXzJ7i0r1vb53dv7A6P3Krgf
         J9Y8rB+Qf0qADXcUDAjzyaLMXiF+lEp/ht8DNJahzY4+sgwzWgfxZNh8c3+aOKwNmgqG
         xtexjFQjF7Cx5Wne4CMb77oFrvag+FB8SjY2q1TBEg1T831eW7zaV4YbAKfuSV3QFtLN
         zpvBc6YmybGn+mRfARA+Hjto+jhxKqdQLhf9f/rp5MF1bKCSOk16FQKA4LkcseiPaHWX
         wvudrDSyHFHV+zOEBL4n3Boa4FWBtSyOy7wkKu/42wl1mXdEf3izfJPHmhUX3UBSBuJB
         TBBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726840435; x=1727445235;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9H+NTeNPvd+4QlpymzpekwJLXBRPMnbrJztLURvIkic=;
        b=rkbQ4n9PADvfYWh+cTZquMhiWuUQ0EUwW5Fmdhn7alrHzIOJhkkop6StktEZdbgCTc
         QnB/MDBKYAlieuMoSHAWq0xbGiN7sTRMqhcw+LisBuxssFb4esPgPEPu0hUKRNBT1xGq
         PohmDG9wYsQkHfSmXEbuKbvbrBtdHMvbSIGQ/mZcs6ZYitqNF+egc6WlnV/V1n3I+PnJ
         HF0xk3Dpe2mGTaTcoW1U3VYM0nybthKnEfgZDBvvHojD9+A05xw152F699Fyf/X51NzX
         tpQyOMg+JBnwopziRCGjnguXdJ8aSUXAeS3UTcGiKXa7cukOTDfxOapGHGTjRvzhNx4p
         IfVg==
X-Forwarded-Encrypted: i=1; AJvYcCVAuxe7kwB3QYKsZUEL06I6P49hdHfCyZdY4TovCHjQdJbQ1k68VLt3WSnNlX7OdpZ4RzcV9Vs=@vger.kernel.org, AJvYcCVv0AR/qKdEYol9EGyIbPNn70S5CqeOdbRvCuYF4THZSS44rIZcLcJeLqmDIiAgUKrszkQS1RHtKNSW0LbaFsc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxizAV/0fX9ZqSaRs+0V9f3Sj+WvIs49CUJOrvCbJyxr8LFboRg
	86HhnBlwe+5Fdp0J4QlflmjZlIS2qzgQTVEOre82/NsidKl/jK/v
X-Google-Smtp-Source: AGHT+IH8586wJN317NDn+P7Vlxc6WBVY2Ptv30Ux+6Dyv5x10sDhTs5i2zYNosWpNdddZ8Un4bFIdQ==
X-Received: by 2002:a17:903:2412:b0:205:8b84:d60c with SMTP id d9443c01a7336-208d83cac85mr44408885ad.35.1726840434889;
        Fri, 20 Sep 2024 06:53:54 -0700 (PDT)
Received: from localhost (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20794731afasm95257645ad.272.2024.09.20.06.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 06:53:54 -0700 (PDT)
Date: Fri, 20 Sep 2024 13:53:39 +0000 (UTC)
Message-Id: <20240920.135339.42277957091918023.fujita.tomonori@gmail.com>
To: aliceryhl@google.com
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch, tmgross@umich.edu,
 lkp@intel.com
Subject: Re: [PATCH net] net: phy: qt2025: Fix warning: unused import
 DeviceId
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <CAH5fLgiJyvSztvCDz8KZ4kF0--a0mqi7M4WowB==CCs2FmVk8A@mail.gmail.com>
References: <20240919043707.206400-1-fujita.tomonori@gmail.com>
	<CAH5fLgiJyvSztvCDz8KZ4kF0--a0mqi7M4WowB==CCs2FmVk8A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: base64

SGksDQoNCk9uIFRodSwgMTkgU2VwIDIwMjQgMDg6MTc6NDIgKzAyMDANCkFsaWNlIFJ5aGwgPGFs
aWNlcnlobEBnb29nbGUuY29tPiB3cm90ZToNCg0KPiBPbiBUaHUsIFNlcCAxOSwgMjAyNCBhdCA2
OjM54oCvQU0gRlVKSVRBIFRvbW9ub3JpDQo+IDxmdWppdGEudG9tb25vcmlAZ21haWwuY29tPiB3
cm90ZToNCj4+DQo+PiBGaXggdGhlIGZvbGxvd2luZyB3YXJuaW5nIHdoZW4gdGhlIGRyaXZlciBp
cyBjb21waWxlZCBhcyBidWlsdC1pbjoNCj4+DQo+PiA+PiB3YXJuaW5nOiB1bnVzZWQgaW1wb3J0
OiBgRGV2aWNlSWRgDQo+PiAgICAtLT4gZHJpdmVycy9uZXQvcGh5L3F0MjAyNS5yczoxODo1DQo+
PiAgICB8DQo+PiAgICAxOCB8ICAgICBEZXZpY2VJZCwgRHJpdmVyLA0KPj4gICAgfCAgICAgXl5e
Xl5eXl4NCj4+ICAgIHwNCj4+ICAgID0gbm90ZTogYCNbd2Fybih1bnVzZWRfaW1wb3J0cyldYCBv
biBieSBkZWZhdWx0DQo+Pg0KPj4gZGV2aWNlX3RhYmxlIGluIG1vZHVsZV9waHlfZHJpdmVyIG1h
Y3JvIGlzIGRlZmluZWQgb25seSB3aGVuIHRoZQ0KPj4gZHJpdmVyIGlzIGJ1aWx0IGFzIG1vZHVs
ZS4gVXNlIGFuIGFic29sdXRlIG1vZHVsZSBwYXRoIGluIHRoZSBtYWNybw0KPj4gaW5zdGVhZCBv
ZiBpbXBvcnRpbmcgYERldmljZUlkYC4NCj4+DQo+PiBSZXBvcnRlZC1ieToga2VybmVsIHRlc3Qg
cm9ib3QgPGxrcEBpbnRlbC5jb20+DQo+PiBDbG9zZXM6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L29lLWtidWlsZC1hbGwvMjAyNDA5MTkwNzE3LmkxMzVyZlZvLWxrcEBpbnRlbC5jb20vDQo+PiBT
aWduZWQtb2ZmLWJ5OiBGVUpJVEEgVG9tb25vcmkgPGZ1aml0YS50b21vbm9yaUBnbWFpbC5jb20+
DQo+IA0KPiBJdCBtYXkgYmUgbmljZSB0byBjaGFuZ2UgdGhlIG1hY3JvIHRvIGFsd2F5cyB1c2Ug
dGhlIGV4cHJlc3Npb24gc28NCj4gdGhhdCB0aGlzIHdhcm5pbmcgZG9lc24ndCBoYXBwZW4gYWdh
aW4uDQoNCkxpa2UgdGhlIEMgY29kZSBkb2VzLCBhIHZhbHVhYmxlIGlzIGRlZmluZWQgb25seSB3
aGVuIHRoZSBkcml2ZXIgaXMNCmJ1aWx0IGFzIG1vZHVsZSBiZWNhdXNlIHRoZSB2YWx1YWJsZSBp
cyB1c2VkIHRvIGNyZWF0ZSB0aGUgaW5mb3JtYXRpb24NCmZvciBtb2R1bGUgbG9hZGluZy4gU28g
dGhlIG1hY3JvIGFkZHMgYCNbY2ZnKE1PRFVMRSldYCBsaWtlIHRoZQ0KZm9sbG93aW5nOg0KDQoj
W2NmZyhNT0RVTEUpXQ0KI1tub19tYW5nbGVdDQpzdGF0aWMgX19tb2RfbWRpb19fcGh5ZGV2X2Rl
dmljZV90YWJsZTogWzo6a2VybmVsOjpiaW5kaW5nczo6bWRpb19kZXZpY2VfaWQ7IDJdID0gWw0K
ICAgIDo6a2VybmVsOjpiaW5kaW5nczo6bWRpb19kZXZpY2VfaWQgew0KICAgICAgICBwaHlfaWQ6
IDB4MDAwMDAwMDEsDQogICAgICAgIHBoeV9pZF9tYXNrOiAweGZmZmZmZmZmLA0KICAgIH0sDQog
ICAgOjprZXJuZWw6OmJpbmRpbmdzOjptZGlvX2RldmljZV9pZCB7DQogICAgICAgIHBoeV9pZDog
MCwNCiAgICAgICAgcGh5X2lkX21hc2s6IDAsDQogICAgfSwNCl07DQoNCldlIGNhbiByZW1vdmUg
YCNbY2ZnKE1PRFVMRSldYCBob3dldmVyIGFuIHVudXNlZCB2YWx1YWJsZSB0byBhZGRlZCB0bw0K
dGhlIGtlcm5lbCBpbWFnZSB3aGVuIHRoZSBkcml2ZXIgaXMgY29tcGlsZWQgYXMgYnVpbHQtaW4u
IFNlZW1zIHRoYXQNCndpdGggYCNbbm9fbWFuZ2xlXWAsIHRoZSBjb21waWxlciBkb2Vzbid0IGdp
dmUgYSB3YXJuaW5nIGFib3V0IHVudXNlZA0KdmFsdWFibGUgdGhvdWdoLg0KDQpJcyB0aGVyZSBh
IG5pY2Ugd2F5IHRvIGhhbmRsZSBzdWNoIGNhc2U/DQoNCj4gQW55d2F5LCB0aGF0IGlzIGEgc2Vw
YXJhdGUgaXNzdWUuDQo+IA0KPiBSZXZpZXdlZC1ieTogQWxpY2UgUnlobCA8YWxpY2VyeWhsQGdv
b2dsZS5jb20+DQoNClRoYW5rcyBhIGxvdCENCg==

