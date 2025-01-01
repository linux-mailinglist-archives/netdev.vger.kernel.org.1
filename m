Return-Path: <netdev+bounces-154656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 501A49FF4C3
	for <lists+netdev@lfdr.de>; Wed,  1 Jan 2025 19:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43B403A2746
	for <lists+netdev@lfdr.de>; Wed,  1 Jan 2025 18:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B181E1C30;
	Wed,  1 Jan 2025 18:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unrealasia-net.20230601.gappssmtp.com header.i=@unrealasia-net.20230601.gappssmtp.com header.b="zevC39gF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8465517C21C
	for <netdev@vger.kernel.org>; Wed,  1 Jan 2025 18:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735756864; cv=none; b=Ztj0gwhtGjmFgNRfybSqRYvcNvLghD1+DlsulvoCC+X9mRI7ZY9Y8kv6pQXQ8e67OO2ZQU/HRFu2nJZSSP2M60clTr1Pp/6FbECd8l0k9vvUjjjxD9so5INzwMmyhjn9Hh5g0HPXyBsF83fZOfc0Goy1ZPMdgko3h0dmzpIz3yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735756864; c=relaxed/simple;
	bh=LU3G7wVy+RttZT3KWyNpCn8FF/RWmWVyw+isdgQlwcc=;
	h=Date:From:Subject:To:Cc:Message-Id:MIME-Version:Content-Type; b=aUNL0EMYREJvZDZN6wtucEr0V7qseB/JI3Y3vdbHqjZQkT3rEETH/cIPc608+V1Wuwb9ctztImfbAqq/VNnKqNTBYlBM3DBbu5Of56fKou7HOEI/SMBeEVBRZ0PYxc7AYdAeME+yhykGtvvvWrILLANOj3XjavtZQWXRC4CyOW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unrealasia.net; spf=pass smtp.mailfrom=unrealasia.net; dkim=pass (2048-bit key) header.d=unrealasia-net.20230601.gappssmtp.com header.i=@unrealasia-net.20230601.gappssmtp.com header.b=zevC39gF; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unrealasia.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unrealasia.net
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2efb17478adso14516369a91.1
        for <netdev@vger.kernel.org>; Wed, 01 Jan 2025 10:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unrealasia-net.20230601.gappssmtp.com; s=20230601; t=1735756861; x=1736361661; darn=vger.kernel.org;
        h=mime-version:message-id:cc:to:subject:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=V9ANSMwBXQIw9fPQUhhtEY8uNvGZwuLxXrj3cDGzSWA=;
        b=zevC39gFJXTcA+74H5Uxzp9vB6Yd74MzP6tVqhpB1m9vUOJpsUCSDgJxTyrCNqe0ZZ
         5koHaUxk+jy92H/PHqx1brhN2BEomFIqtDCj/NTelFIulJUoSH7PA9mLQ+y9ub/AQvy9
         VyrEwMDf6F/T+faHYTR3a1JZfOocGdlzNp2RXO9jOWkPn6000K+uSYrByMmuGTxKZ97T
         HbEcuDLMlJXR+N1ww8mDe7xafLGLyc5aorI/EFiWdCy91wEw6T2gYzEjqe6gQd0+MUN6
         7rZms/UM5v19wzRkkwc7PipSXeQ5caGRGfiwxXX2ypeUNGgFpadVhjv9JyjXJfw3PYvu
         META==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735756861; x=1736361661;
        h=mime-version:message-id:cc:to:subject:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V9ANSMwBXQIw9fPQUhhtEY8uNvGZwuLxXrj3cDGzSWA=;
        b=VdsxaDY9xTgGVZlS3BHMrL3YnccHbn9llSXNoeLytibDt7+6t0G6Cw8c2ykZT3D+Ur
         AW8PhNq/rvAQX4g2a5KaUsnKxBgJtIlXhqhwvBxpxNZzttkAai77RS/y+oJvNe+jV4Mj
         s14C37MINeQm2/USDvDBuJjmnqU7r1RFnqJNrlaeLqCWe57xIKKCK6BUW3B0F26Vxc80
         DhDVvy440MoFg4j82oWjnyBRUjaT7ZHZz3hDnARP3QR1KrW6k4V32bB77D49fNQ86scH
         qiRPsB1amP/IGOjb6SleWrayFRRzJJQ5hNslx9OoKyyVTdU9Qy+AjmtK53/8vf9PIW9b
         FtFQ==
X-Gm-Message-State: AOJu0YzeGE8gau/8/qRwX0Ei1s/SBOg5emY2QAXC25mHQf1R/HGJMdFb
	7ya847/GpFoZRPsNycLYy2eY/IQMK4fhXI+wU2oVTKmEkvtiT/JkxuNPqlmGtAMMK3VYc/53Upt
	1tZsBTQ==
X-Gm-Gg: ASbGncti47Evt83CvVLB3WlWQsQLtbw5juFMJoxiqq+mDQZf7uDoy9gLGT6LGofqBYn
	1OGNMCYiGZZwcxyxxZr/3BVEHFJUxCpt7USxl7UFTPZWvr89U6rIiHXBS3bVQ0ulw+84GQ3qyyP
	bj4uTxSiC6yJKxgucmLVUUwoVNhlCXIhp+gx2D9vAZjeTQK6A8/HBLI3HFNW4TsbDFB86/znUhQ
	dHGMLOfPuimWTJsTlIfcRJ8m5EF+9qcov/0nB6ZBfA2PSc8MyXk+t3VDhxtBKA=
X-Google-Smtp-Source: AGHT+IFE0bD3Ch5DK/YWmtdL6RDV1VMmTCn9McSg1J5iWgWQQuuToJPMCRHTGOSxY/IYGFFoV9L9pg==
X-Received: by 2002:a17:90b:2b8b:b0:2ee:7862:1b10 with SMTP id 98e67ed59e1d1-2f452e2256bmr63405306a91.11.1735756861015;
        Wed, 01 Jan 2025 10:41:01 -0800 (PST)
Received: from [10.23.230.78] ([175.143.24.165])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f4da93a04esm2033428a91.11.2025.01.01.10.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jan 2025 10:41:00 -0800 (PST)
Date: Thu, 02 Jan 2025 02:34:03 +0800
From: Muhammad Nuzaihan <zaihan@unrealasia.net>
Subject: [PATCH] Add NMEA GPS character device for PCIe MHI Quectel Module to
 read NMEA statements.
To: netdev@vger.kernel.org
Cc: Loic Poulain <loic.poulain@linaro.org>, Sergey Ryazanov
	<ryazanov.s.a@gmail.com>, Johannes Berg <johannes@sipsolutions.net>
Message-Id: <R8AFPS.THYVK2DKSEE83@unrealasia.net>
X-Mailer: geary/40.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-0Yt3WiEz0b8aOe6aH34X"

--=-0Yt3WiEz0b8aOe6aH34X
Content-Type: text/plain; charset=us-ascii; format=flowed

Hi netdev,

I am using a Quectel RM520N-GL *PCIe* (not USB) module which uses the 
MHI interface.

In /devices/pci0000:00/0000:00:1c.6/0000:08:00.0/mhi0 i can see 
"mhi0_NMEA" but the actual NMEA device is missing in /dev and needs a 
character device to be useful with tty programs.

NMEA statements are a stream of GPS information which is used to tell 
the current device location in the console (like minicom).

Attached is the patch to ensure a device is registered (as 
/dev/wwan0nmea0) so this device will stream GPS NMEA statements and can 
be used to be read by popular GPS tools like gpsd and then tracking 
with cgps, xgps, QGIS, etc.

Regards,
Muhammad Nuzaihan

Signed-off-by: Muhammad Nuzaihan Bin Kamal Luddin 
<zaihan@unrealasia.net>


--=-0Yt3WiEz0b8aOe6aH34X
Content-Type: text/x-patch
Content-Disposition: attachment; filename=quectel-nmea-gps-port-interface.patch
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3d3YW4vaW9zbS9pb3NtX2lwY19jaG5sX2NmZy5jIGIv
ZHJpdmVycy9uZXQvd3dhbi9pb3NtL2lvc21faXBjX2NobmxfY2ZnLmMKaW5kZXggYmNmYmM2YjNk
NjE3Li40ZDRmYzM4MTNjODYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbmV0L3d3YW4vaW9zbS9pb3Nt
X2lwY19jaG5sX2NmZy5jCisrKyBiL2RyaXZlcnMvbmV0L3d3YW4vaW9zbS9pb3NtX2lwY19jaG5s
X2NmZy5jCkBAIC02MCw2ICs2MCwxMCBAQCBzdGF0aWMgc3RydWN0IGlwY19jaG5sX2NmZyBtb2Rl
bV9jZmdbXSA9IHsKIAl7IElQQ19NRU1fQ1RSTF9DSExfSURfNiwgSVBDX01FTV9QSVBFXzEyLCBJ
UENfTUVNX1BJUEVfMTMsCiAJICBJUENfTUVNX01BWF9URFNfTUJJTSwgSVBDX01FTV9NQVhfVERT
X01CSU0sCiAJICBJUENfTUVNX01BWF9ETF9NQklNX0JVRl9TSVpFLCBXV0FOX1BPUlRfTUJJTSB9
LAorCS8qIE5NRUEgKi8KKwl7IElQQ19NRU1fQ1RSTF9DSExfSURfNywgSVBDX01FTV9QSVBFXzE0
LCBJUENfTUVNX1BJUEVfMTUsCisJICBJUENfTUVNX01BWF9URFNfQVQsIElQQ19NRU1fTUFYX1RE
U19BVCwgSVBDX01FTV9NQVhfRExfQVRfQlVGX1NJWkUsCisJICBXV0FOX1BPUlRfTk1FQSB9LAog
CS8qIEZsYXNoIENoYW5uZWwvQ29yZWR1bXAgQ2hhbm5lbCAqLwogCXsgSVBDX01FTV9DVFJMX0NI
TF9JRF83LCBJUENfTUVNX1BJUEVfMCwgSVBDX01FTV9QSVBFXzEsCiAJICBJUENfTUVNX01BWF9U
RFNfRkxBU0hfVUwsIElQQ19NRU1fTUFYX1REU19GTEFTSF9ETCwKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvbmV0L3d3YW4vbWhpX3d3YW5fY3RybC5jIGIvZHJpdmVycy9uZXQvd3dhbi9taGlfd3dhbl9j
dHJsLmMKaW5kZXggZTlmOTc5ZDJkODUxLi5lMTNjMGIwNzgxNzUgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvbmV0L3d3YW4vbWhpX3d3YW5fY3RybC5jCisrKyBiL2RyaXZlcnMvbmV0L3d3YW4vbWhpX3d3
YW5fY3RybC5jCkBAIC0yNjMsNiArMjYzLDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBtaGlfZGV2
aWNlX2lkIG1oaV93d2FuX2N0cmxfbWF0Y2hfdGFibGVbXSA9IHsKIAl7IC5jaGFuID0gIlFNSSIs
IC5kcml2ZXJfZGF0YSA9IFdXQU5fUE9SVF9RTUkgfSwKIAl7IC5jaGFuID0gIkRJQUciLCAuZHJp
dmVyX2RhdGEgPSBXV0FOX1BPUlRfUUNETSB9LAogCXsgLmNoYW4gPSAiRklSRUhPU0UiLCAuZHJp
dmVyX2RhdGEgPSBXV0FOX1BPUlRfRklSRUhPU0UgfSwKKwl7IC5jaGFuID0gIk5NRUEiLCAuZHJp
dmVyX2RhdGEgPSBXV0FOX1BPUlRfTk1FQSB9LAogCXt9LAogfTsKIE1PRFVMRV9ERVZJQ0VfVEFC
TEUobWhpLCBtaGlfd3dhbl9jdHJsX21hdGNoX3RhYmxlKTsKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
bmV0L3d3YW4vd3dhbl9jb3JlLmMgYi9kcml2ZXJzL25ldC93d2FuL3d3YW5fY29yZS5jCmluZGV4
IGE1MWUyNzU1OTkxYS4uMDEzMWQ5Nzk1ZDZjIDEwMDY0NAotLS0gYS9kcml2ZXJzL25ldC93d2Fu
L3d3YW5fY29yZS5jCisrKyBiL2RyaXZlcnMvbmV0L3d3YW4vd3dhbl9jb3JlLmMKQEAgLTM0Miw2
ICszNDIsMTAgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCB7CiAJCS5uYW1lID0gIk1JUEMiLAogCQku
ZGV2c3VmID0gIm1pcGMiLAogCX0sCisJW1dXQU5fUE9SVF9OTUVBXSA9IHsKKwkJLm5hbWUgPSAi
Tk1FQSIsCisJCS5kZXZzdWYgPSAibm1lYSIsCisJfSwKIH07CiAKIHN0YXRpYyBzc2l6ZV90IHR5
cGVfc2hvdyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBkZXZpY2VfYXR0cmlidXRlICphdHRy
LApAQCAtODc2LDcgKzg4MCw4IEBAIHN0YXRpYyBsb25nIHd3YW5fcG9ydF9mb3BzX2lvY3RsKHN0
cnVjdCBmaWxlICpmaWxwLCB1bnNpZ25lZCBpbnQgY21kLAogCXN0cnVjdCB3d2FuX3BvcnQgKnBv
cnQgPSBmaWxwLT5wcml2YXRlX2RhdGE7CiAJaW50IHJlczsKIAotCWlmIChwb3J0LT50eXBlID09
IFdXQU5fUE9SVF9BVCkgewkvKiBBVCBwb3J0IHNwZWNpZmljIElPQ1RMcyAqLworCWlmIChwb3J0
LT50eXBlID09IFdXQU5fUE9SVF9BVCB8fAorCQkJV1dBTl9QT1JUX05NRUEpIHsJLyogQVQgb3Ig
Tk1FQSBwb3J0IHNwZWNpZmljIElPQ1RMcyAqLwogCQlyZXMgPSB3d2FuX3BvcnRfZm9wc19hdF9p
b2N0bChwb3J0LCBjbWQsIGFyZyk7CiAJCWlmIChyZXMgIT0gLUVOT0lPQ1RMQ01EKQogCQkJcmV0
dXJuIHJlczsKZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvd3dhbi5oIGIvaW5jbHVkZS9saW51
eC93d2FuLmgKaW5kZXggNzljNzgxODc1YzA5Li45ZTc5NGZjNTNhN2UgMTAwNjQ0Ci0tLSBhL2lu
Y2x1ZGUvbGludXgvd3dhbi5oCisrKyBiL2luY2x1ZGUvbGludXgvd3dhbi5oCkBAIC0xOSw2ICsx
OSw3IEBACiAgKiBAV1dBTl9QT1JUX0ZBU1RCT09UOiBGYXN0Ym9vdCBwcm90b2NvbCBjb250cm9s
CiAgKiBAV1dBTl9QT1JUX0FEQjogQURCIHByb3RvY29sIGNvbnRyb2wKICAqIEBXV0FOX1BPUlRf
TUlQQzogTVRLIE1JUEMgZGlhZ25vc3RpYyBpbnRlcmZhY2UKKyAqIEBXV0FOX1BPUlRfTk1FQTog
Tk1FQSBHUFMgc3RhdGVtZW50cyBpbnRlcmZhY2UKICAqCiAgKiBAV1dBTl9QT1JUX01BWDogSGln
aGVzdCBzdXBwb3J0ZWQgcG9ydCB0eXBlcwogICogQFdXQU5fUE9SVF9VTktOT1dOOiBTcGVjaWFs
IHZhbHVlIHRvIGluZGljYXRlIGFuIHVua25vd24gcG9ydCB0eXBlCkBAIC0zNCw2ICszNSw3IEBA
IGVudW0gd3dhbl9wb3J0X3R5cGUgewogCVdXQU5fUE9SVF9GQVNUQk9PVCwKIAlXV0FOX1BPUlRf
QURCLAogCVdXQU5fUE9SVF9NSVBDLAorCVdXQU5fUE9SVF9OTUVBLAogCiAJLyogQWRkIG5ldyBw
b3J0IHR5cGVzIGFib3ZlIHRoaXMgbGluZSAqLwogCg==

--=-0Yt3WiEz0b8aOe6aH34X--


