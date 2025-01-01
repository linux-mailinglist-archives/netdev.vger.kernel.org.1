Return-Path: <netdev+bounces-154658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 047149FF4F1
	for <lists+netdev@lfdr.de>; Wed,  1 Jan 2025 22:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89A21161C47
	for <lists+netdev@lfdr.de>; Wed,  1 Jan 2025 21:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7571E2844;
	Wed,  1 Jan 2025 21:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unrealasia-net.20230601.gappssmtp.com header.i=@unrealasia-net.20230601.gappssmtp.com header.b="VvSs1tv5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD751184E
	for <netdev@vger.kernel.org>; Wed,  1 Jan 2025 21:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735765973; cv=none; b=stPsbvb0WH/PF8L8zIAV/TVuQkeKVJ++bPPRyyQ7a1aQ/ZePc+nwLacVOE3Mrw80DjnK+GdKDwJOPfEcKQo3dDPme8IAUSopJtmvYx2l643chRKCIMrnP7DBVhV6eOijYiweAc86Fd8WWzlX/h1E2JJakrJsXGwVv/Ch6ZXrC/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735765973; c=relaxed/simple;
	bh=PiHijKd50MzLY6/2PuudCOTPHSqllx7xXIJNDnwpick=;
	h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SV/hOxL7UQQXn1ZTByt9ufSWCfNrINo3whV56hz3vE0g6HYTMGmHcspl9kcWQgVTXOCubcJHqkvrXbuwh9Pbqh76S9bH4CDQ9FEdZUEhgrVkEQa13J2s5Cc4Dan6TERYj99TZM7Bsq8Yp8EvZFn3dFhJqAquB49lIfkyV1R/5kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unrealasia.net; spf=pass smtp.mailfrom=unrealasia.net; dkim=pass (2048-bit key) header.d=unrealasia-net.20230601.gappssmtp.com header.i=@unrealasia-net.20230601.gappssmtp.com header.b=VvSs1tv5; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unrealasia.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unrealasia.net
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2163bd70069so47060645ad.0
        for <netdev@vger.kernel.org>; Wed, 01 Jan 2025 13:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unrealasia-net.20230601.gappssmtp.com; s=20230601; t=1735765970; x=1736370770; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AOBf0uW+nOaln9RUVEsy3EpSw59JrDZeP+HyYDaZPBw=;
        b=VvSs1tv5GGbHab15yunPPhINaEpktOVXv76mfwqjLnz2Bxq7G3L7MmwAffMf/UfrGI
         aTfe1qGNGOAo4QDm7FimFPLPxZhYl5lLS3SbEekmSH3JpAwlqx0qtRmcd08/0K52/qYP
         4BsEqhRtnOrEXp0XMwZExFWnDo4XB5Dx6MoIZuTrSQ19IKfeG8npW3VRIu/7zCMXvglq
         s87ItCirlVCqvss0cJ5TN9MDpC8OmtnRZHHSY6GJ3nNJKMfjJNMt5oUEZbFMCEZ9Umw5
         jLRg5OWlt+5QmsS0swqJn6xAD8ivD+NlgyExBOEsnLCmic0IyTXBnLAWwwMWYLom8Rf5
         vUhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735765970; x=1736370770;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AOBf0uW+nOaln9RUVEsy3EpSw59JrDZeP+HyYDaZPBw=;
        b=a3djmaY/+QxJNtvzgeYqdNeegQDpZdWHMEJ2Bhosc8x+zGtzQ7EuEcwJ/JLS9iCHCm
         Y8AiYDnhxQ7TybV8NB5ddp9FFbJZtTLpKZI1beNlsjX74kpNSXO32d7P730BmfoE6uCD
         go1zi0ae/oBtFk/nvGFwFlLbf04/WxRU48tZLib3k/AaaF7Zn/D0m4kGweDAsG99LL+y
         erWrQSAOIo7xTYCNUl77haj42GD6u/eHP1NK8wEBisYw9AstYGU4kT92RyhNe9Um7tPh
         sRUX7QhhOUy9WGf8AwXJLiaMaWYtqJiyUFZn6WIO8/p4yETwf8pL6qflcGLvbW6VGet2
         BNHQ==
X-Gm-Message-State: AOJu0YwSw5TC2Rk9pgpPQfErJYbGsGF37pHb6QtZbfNqUYs2LJ/9FDCu
	To2O9dlNqVgsLg3DHjTVJVs8yAWHVw++sOt0ndIcc0j3XoQ0CoczecI8g8l0Lfm1/BC28otyK/J
	p
X-Gm-Gg: ASbGncvItY+i74JY3/FIN9QbdzDY2hfoShtnxBSNzzNIzvsqskEs2uK5NwxCLNkQw9J
	xtk0mGNfeIimSrm4z+vl3crl94K0IM16CMpsdHqFRXmgojzWbwk9XA941c4xxdLfQ6BXFTU5Arh
	shvtnbftjCGM1TWp4XJRu3k2DiGjlLNY+SsmvWgPwsntXC9QXk6DInTyJ6joNeqf2TQW4vRlL6T
	HbSENEIkQ0Rp5drOVmJLLJm25YjhmQKISIHBBpJPa1J+KETau1fTIK7168XRLujkgk/eLQ=
X-Google-Smtp-Source: AGHT+IFtePGi+HhDcmin+pq1ohO2bQLzvsnWXn2d0u8xxv8WDBZCu+xL9kVgAM/GVLah2UbejXKosQ==
X-Received: by 2002:a17:902:fc84:b0:215:b01a:627f with SMTP id d9443c01a7336-219e6e89585mr660763005ad.4.1735765970127;
        Wed, 01 Jan 2025 13:12:50 -0800 (PST)
Received: from muhammads-ThinkPad ([2402:1980:248:9dcd:34bd:62b4:6725:e86a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9d4458sm214326885ad.114.2025.01.01.13.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jan 2025 13:12:49 -0800 (PST)
Date: Thu, 02 Jan 2025 05:12:41 +0800
From: Muhammad Nuzaihan <zaihan@unrealasia.net>
Subject: Re: [PATCH] Add NMEA GPS character device for PCIe MHI Quectel Module
 to read NMEA statements.
To: netdev@vger.kernel.org
Cc: Loic Poulain <loic.poulain@linaro.org>, Sergey Ryazanov
	<ryazanov.s.a@gmail.com>, Johannes Berg <johannes@sipsolutions.net>
Message-Id: <5LHFPS.G3DNPFBCDKCL2@unrealasia.net>
In-Reply-To: <R8AFPS.THYVK2DKSEE83@unrealasia.net>
References: <R8AFPS.THYVK2DKSEE83@unrealasia.net>
X-Mailer: geary/40.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-UBqynKXzkn4dNSh4Ns0l"

--=-UBqynKXzkn4dNSh4Ns0l
Content-Type: text/plain; charset=us-ascii; format=flowed

Hi netdev,

I made a mistake in choosing AT mode IPC, which is incorrect. For NMEA 
streams it should use LOOPBACK for IPC. If it uses AT, i noticed that 
using gpsd will cause intermittent IOCTL errors which is caused when 
gpsd wants to write to the device.

Attached is the patch.

Thank you.

Signed-off-by: Muhammad Nuzaihan Bin Kamal Luddin 
<zaihan@unrealasia.net>

On Thu, Jan 2 2025 at 02:34:03 AM +0800, Muhammad Nuzaihan 
<zaihan@unrealasia.net> wrote:
> Hi netdev,
> 
> I am using a Quectel RM520N-GL *PCIe* (not USB) module which uses the 
> MHI interface.
> 
> In /devices/pci0000:00/0000:00:1c.6/0000:08:00.0/mhi0 i can see 
> "mhi0_NMEA" but the actual NMEA device is missing in /dev and needs a 
> character device to be useful with tty programs.
> 
> NMEA statements are a stream of GPS information which is used to tell 
> the current device location in the console (like minicom).
> 
> Attached is the patch to ensure a device is registered (as 
> /dev/wwan0nmea0) so this device will stream GPS NMEA statements and 
> can be used to be read by popular GPS tools like gpsd and then 
> tracking with cgps, xgps, QGIS, etc.
> 
> Regards,
> Muhammad Nuzaihan
> 
> Signed-off-by: Muhammad Nuzaihan Bin Kamal Luddin 
> <zaihan@unrealasia.net>
> 


--=-UBqynKXzkn4dNSh4Ns0l
Content-Type: text/x-patch
Content-Disposition: attachment;
	filename=quectel-nmea-gps-port-interface-2.patch
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3d3YW4vaW9zbS9pb3NtX2lwY19jaG5sX2NmZy5jIGIv
ZHJpdmVycy9uZXQvd3dhbi9pb3NtL2lvc21faXBjX2NobmxfY2ZnLmMKaW5kZXggYmNmYmM2YjNk
NjE3Li43NWI5ZjlhNDNmNDEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbmV0L3d3YW4vaW9zbS9pb3Nt
X2lwY19jaG5sX2NmZy5jCisrKyBiL2RyaXZlcnMvbmV0L3d3YW4vaW9zbS9pb3NtX2lwY19jaG5s
X2NmZy5jCkBAIC02MCw2ICs2MCwxMCBAQCBzdGF0aWMgc3RydWN0IGlwY19jaG5sX2NmZyBtb2Rl
bV9jZmdbXSA9IHsKIAl7IElQQ19NRU1fQ1RSTF9DSExfSURfNiwgSVBDX01FTV9QSVBFXzEyLCBJ
UENfTUVNX1BJUEVfMTMsCiAJICBJUENfTUVNX01BWF9URFNfTUJJTSwgSVBDX01FTV9NQVhfVERT
X01CSU0sCiAJICBJUENfTUVNX01BWF9ETF9NQklNX0JVRl9TSVpFLCBXV0FOX1BPUlRfTUJJTSB9
LAorCS8qIE5NRUEgKi8KKwl7IElQQ19NRU1fQ1RSTF9DSExfSURfNywgSVBDX01FTV9QSVBFXzE0
LCBJUENfTUVNX1BJUEVfMTUsCisgICAgICAgICAgSVBDX01FTV9NQVhfVERTX0xPT1BCQUNLLCBJ
UENfTUVNX01BWF9URFNfTE9PUEJBQ0ssCisgICAgICAgICAgSVBDX01FTV9NQVhfRExfTE9PUEJB
Q0tfU0laRSwgV1dBTl9QT1JUX05NRUEgfSwKIAkvKiBGbGFzaCBDaGFubmVsL0NvcmVkdW1wIENo
YW5uZWwgKi8KIAl7IElQQ19NRU1fQ1RSTF9DSExfSURfNywgSVBDX01FTV9QSVBFXzAsIElQQ19N
RU1fUElQRV8xLAogCSAgSVBDX01FTV9NQVhfVERTX0ZMQVNIX1VMLCBJUENfTUVNX01BWF9URFNf
RkxBU0hfREwsCmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93d2FuL21oaV93d2FuX2N0cmwuYyBi
L2RyaXZlcnMvbmV0L3d3YW4vbWhpX3d3YW5fY3RybC5jCmluZGV4IGU5Zjk3OWQyZDg1MS4uZTEz
YzBiMDc4MTc1IDEwMDY0NAotLS0gYS9kcml2ZXJzL25ldC93d2FuL21oaV93d2FuX2N0cmwuYwor
KysgYi9kcml2ZXJzL25ldC93d2FuL21oaV93d2FuX2N0cmwuYwpAQCAtMjYzLDYgKzI2Myw3IEBA
IHN0YXRpYyBjb25zdCBzdHJ1Y3QgbWhpX2RldmljZV9pZCBtaGlfd3dhbl9jdHJsX21hdGNoX3Rh
YmxlW10gPSB7CiAJeyAuY2hhbiA9ICJRTUkiLCAuZHJpdmVyX2RhdGEgPSBXV0FOX1BPUlRfUU1J
IH0sCiAJeyAuY2hhbiA9ICJESUFHIiwgLmRyaXZlcl9kYXRhID0gV1dBTl9QT1JUX1FDRE0gfSwK
IAl7IC5jaGFuID0gIkZJUkVIT1NFIiwgLmRyaXZlcl9kYXRhID0gV1dBTl9QT1JUX0ZJUkVIT1NF
IH0sCisJeyAuY2hhbiA9ICJOTUVBIiwgLmRyaXZlcl9kYXRhID0gV1dBTl9QT1JUX05NRUEgfSwK
IAl7fSwKIH07CiBNT0RVTEVfREVWSUNFX1RBQkxFKG1oaSwgbWhpX3d3YW5fY3RybF9tYXRjaF90
YWJsZSk7CmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93d2FuL3d3YW5fY29yZS5jIGIvZHJpdmVy
cy9uZXQvd3dhbi93d2FuX2NvcmUuYwppbmRleCBhNTFlMjc1NTk5MWEuLjAxMzFkOTc5NWQ2YyAx
MDA2NDQKLS0tIGEvZHJpdmVycy9uZXQvd3dhbi93d2FuX2NvcmUuYworKysgYi9kcml2ZXJzL25l
dC93d2FuL3d3YW5fY29yZS5jCkBAIC0zNDIsNiArMzQyLDEwIEBAIHN0YXRpYyBjb25zdCBzdHJ1
Y3QgewogCQkubmFtZSA9ICJNSVBDIiwKIAkJLmRldnN1ZiA9ICJtaXBjIiwKIAl9LAorCVtXV0FO
X1BPUlRfTk1FQV0gPSB7CisJCS5uYW1lID0gIk5NRUEiLAorCQkuZGV2c3VmID0gIm5tZWEiLAor
CX0sCiB9OwogCiBzdGF0aWMgc3NpemVfdCB0eXBlX3Nob3coc3RydWN0IGRldmljZSAqZGV2LCBz
dHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqYXR0ciwKQEAgLTg3Niw3ICs4ODAsOCBAQCBzdGF0aWMg
bG9uZyB3d2FuX3BvcnRfZm9wc19pb2N0bChzdHJ1Y3QgZmlsZSAqZmlscCwgdW5zaWduZWQgaW50
IGNtZCwKIAlzdHJ1Y3Qgd3dhbl9wb3J0ICpwb3J0ID0gZmlscC0+cHJpdmF0ZV9kYXRhOwogCWlu
dCByZXM7CiAKLQlpZiAocG9ydC0+dHlwZSA9PSBXV0FOX1BPUlRfQVQpIHsJLyogQVQgcG9ydCBz
cGVjaWZpYyBJT0NUTHMgKi8KKwlpZiAocG9ydC0+dHlwZSA9PSBXV0FOX1BPUlRfQVQgfHwKKwkJ
CVdXQU5fUE9SVF9OTUVBKSB7CS8qIEFUIG9yIE5NRUEgcG9ydCBzcGVjaWZpYyBJT0NUTHMgKi8K
IAkJcmVzID0gd3dhbl9wb3J0X2ZvcHNfYXRfaW9jdGwocG9ydCwgY21kLCBhcmcpOwogCQlpZiAo
cmVzICE9IC1FTk9JT0NUTENNRCkKIAkJCXJldHVybiByZXM7CmRpZmYgLS1naXQgYS9pbmNsdWRl
L2xpbnV4L3d3YW4uaCBiL2luY2x1ZGUvbGludXgvd3dhbi5oCmluZGV4IDc5Yzc4MTg3NWMwOS4u
OWU3OTRmYzUzYTdlIDEwMDY0NAotLS0gYS9pbmNsdWRlL2xpbnV4L3d3YW4uaAorKysgYi9pbmNs
dWRlL2xpbnV4L3d3YW4uaApAQCAtMTksNiArMTksNyBAQAogICogQFdXQU5fUE9SVF9GQVNUQk9P
VDogRmFzdGJvb3QgcHJvdG9jb2wgY29udHJvbAogICogQFdXQU5fUE9SVF9BREI6IEFEQiBwcm90
b2NvbCBjb250cm9sCiAgKiBAV1dBTl9QT1JUX01JUEM6IE1USyBNSVBDIGRpYWdub3N0aWMgaW50
ZXJmYWNlCisgKiBAV1dBTl9QT1JUX05NRUE6IE5NRUEgR1BTIHN0YXRlbWVudHMgaW50ZXJmYWNl
CiAgKgogICogQFdXQU5fUE9SVF9NQVg6IEhpZ2hlc3Qgc3VwcG9ydGVkIHBvcnQgdHlwZXMKICAq
IEBXV0FOX1BPUlRfVU5LTk9XTjogU3BlY2lhbCB2YWx1ZSB0byBpbmRpY2F0ZSBhbiB1bmtub3du
IHBvcnQgdHlwZQpAQCAtMzQsNiArMzUsNyBAQCBlbnVtIHd3YW5fcG9ydF90eXBlIHsKIAlXV0FO
X1BPUlRfRkFTVEJPT1QsCiAJV1dBTl9QT1JUX0FEQiwKIAlXV0FOX1BPUlRfTUlQQywKKwlXV0FO
X1BPUlRfTk1FQSwKIAogCS8qIEFkZCBuZXcgcG9ydCB0eXBlcyBhYm92ZSB0aGlzIGxpbmUgKi8K
IAo=

--=-UBqynKXzkn4dNSh4Ns0l--


