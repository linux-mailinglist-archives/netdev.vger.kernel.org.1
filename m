Return-Path: <netdev+bounces-244878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DAF0CC0B0F
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 04:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B39CC30341CD
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 03:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A3630BF78;
	Tue, 16 Dec 2025 03:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dO72bJlh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2555830C342
	for <netdev@vger.kernel.org>; Tue, 16 Dec 2025 03:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765854732; cv=none; b=am4AvURyK13SjrYf0QrBOQvObScKaVw5mbh5e/evFgrYIqMghI+GPu0ga1/UTeJQtNhM9m9SqJRESXeGqpcfpeWXfded/oFibQn8kJ46JSGatbFPpizRPsF49sJoqqeXNkzkzf+07Sw0UHbpoAaS+EI/34/74oYEvb6gGl3VUNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765854732; c=relaxed/simple;
	bh=iQmxm0djq24+dQscJhL0ForU9FpsRolrvAnU9DdLBek=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Jq3JaqcPtC7IH8wheIi/P5TixJTAkLybLNK+DVddKB6B8T0tmqQTJxKMlt0tuzhUBfMW6dyr9OsJc3MoFAkjJwVXWwAcgIcnp/VgmYD8wcae2Kr4qybkHxZpJA6xl70VFSsbH7iDrNw6mH4ePpNOZNz1AvXSj5ubhFqN+2HoWSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dO72bJlh; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-786a822e73aso39159407b3.3
        for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 19:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765854729; x=1766459529; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jxBmymWbq42pbYHpVMadjTjXtAOmytXTfzCe3e9J3KU=;
        b=dO72bJlhzC+DoItn/Pu3jzZpzIbsBTzX4EZnUxIlxydeqPaGa1LOXxZ/aOYB7SrPpE
         jHCKUHS9TXqbY/9HXlZ+meesUUF4sDK7ZGNndgEK7+M+nRfYl0DZUjYv4XJxi1w3tsux
         U7eH7WW0vX6FrGQ1UNc/Fotc0cAc+skZgxOylgzU90FMm0knZygH+LHoiF2Fwfg8+ybw
         UrYKfji9bowOonPETyC8jyXXNurgEaoKJFYUsNEQJYMu8DlQHoIi5vTdAhLceK0MMf3n
         ZY8bRVlLoKu/o+5mv/JuwBfbXPliNthyqsm7rxPSxz8jITxtsv0VkHA30qT7j2QJ7NrW
         wLdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765854729; x=1766459529;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jxBmymWbq42pbYHpVMadjTjXtAOmytXTfzCe3e9J3KU=;
        b=PV4bpoC/YYWh9RJxhYI9uI1GQGVVSDhmI3lVDEVvrJlG/nrotbX1GgZpo7TiRDtNdT
         TrCnDwIeMytmfRNnlsAr0uSRe7TxEsKUFnthe8j6eP1iEatTJqhnfXxB7T3abocv19FX
         RA5ggDDXPSqm+jFiQ1gsqiqm6eMVo0aH+ysbsiHCbmbaKFzZ/2HinY9ptujL1KAom2ax
         mJHVUe3wmo7vE4F6oe83TrbJzpS68Miy8dL4x0Mi7DkJZ/pg/yDmReOBbc3VBTi8y9KI
         jhSKrjix8BuJQl3H+c2qeUVRa9q3zJzyfOj955j/9oVqE6GzkPtxIBZQ+n+g8zng/fU7
         oAsg==
X-Forwarded-Encrypted: i=1; AJvYcCWUZDCh2rN9JalPCTTf9kE483gWaEuTJ6AsXy1FlVV5Y4Mx6GIUp9wDMaonfsK1uc4/t69fojY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz2Eqm1X7a7vq4kSwsVsNiOSLOP+SAm+dig4cmXlqinDB1aTnJ
	d8AcDTuuxq3+7UkVt4HuuRVMu8VedQI70AUwb98UykbgGGNgp4uYjQz+wL4zybN5UsWfvVysBF+
	z8S32rVAu1oRXc065sfmXViLu+N/4H74=
X-Gm-Gg: AY/fxX4qmXYMk820QB8Mwvt/mWrQaLZM3xSJEAtD2vqyOAchnTNdOM85/qnH4iD0hvT
	uOtg6YzG8AnRxBvP5qvPOKFhKEHrOlsEKNzSP48i80fspIfqA/SE2Vd/L/Tbv8hHjlhcdnqR/c0
	0EOfAuhsN874y5R+FASAsPJS98jSdVzckY+XlmyvKhJ1IeaFyTX7t6yN7mRYMWYzMjlSOL7mI/q
	uWHLqAP3dTYL73Elpv/1V0sXHC6W1v7/206uL+yNPsT9i+YrbeDi6chTore6VKE3rkCTIQ=
X-Google-Smtp-Source: AGHT+IGF4iw0eMVT0qB8Rqb2/V88dVdoZtjzlWdTdwpVCH+UwTUUlZKOdiMTIrXl3igXC2i7+6CpqaNxeal2mT5aFlU=
X-Received: by 2002:a05:690e:16a0:b0:645:5413:f782 with SMTP id
 956f58d0204a3-645555cdbf2mr9811003d50.16.1765854728785; Mon, 15 Dec 2025
 19:12:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Moon Hee Lee <moonhee.lee.ca@gmail.com>
Date: Mon, 15 Dec 2025 19:11:57 -0800
X-Gm-Features: AQt7F2oRBJRbC_70WyQF5RC9wQcDC4FaGz_qowmfR_f-OE8n9-YoUFojS7vrVKM
Message-ID: <CAF3JpA4Yk03Zeju9Y4MMSS0ynAP+qrk1fXiu_CGV1G+ffC-NiQ@mail.gmail.com>
Subject: Re: [syzbot] [wireless?] WARNING in ieee80211_ocb_rx_no_sta (2)
To: syzbot+b364457b2d1d4e4a3054@syzkaller.appspotmail.com, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000d61efc06460917ef"

--000000000000d61efc06460917ef
Content-Type: text/plain; charset="UTF-8"

#syz test

--000000000000d61efc06460917ef
Content-Type: application/octet-stream; 
	name="0001-mac80211-ocb-skip-rx_no_sta-when-interface-is-not-jo.patch"
Content-Disposition: attachment; 
	filename="0001-mac80211-ocb-skip-rx_no_sta-when-interface-is-not-jo.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mj806iiv0>
X-Attachment-Id: f_mj806iiv0

RnJvbSAyNDIyNzc1YTBjZGM1MDQwMjhiMTk4MGQxODE5NjhkMjgyYTY5ODMyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNb29uIEhlZSBMZWUgPG1vb25oZWUubGVlLmNhQGdtYWlsLmNv
bT4KRGF0ZTogTW9uLCAxNSBEZWMgMjAyNSAxNTozNzo1MCAtMDgwMApTdWJqZWN0OiBbUEFUQ0hd
IG1hYzgwMjExOiBvY2I6IHNraXAgcnhfbm9fc3RhIHdoZW4gaW50ZXJmYWNlIGlzIG5vdCBqb2lu
ZWQKCmllZWU4MDIxMV9vY2Jfcnhfbm9fc3RhKCkgYXNzdW1lcyBhIHZhbGlkIGNoYW5uZWwgY29u
dGV4dCwgd2hpY2ggaXMgb25seQpwcmVzZW50IGFmdGVyIEpPSU5fT0NCLgoKUlggbWF5IHJ1biBi
ZWZvcmUgSk9JTl9PQ0IgaXMgZXhlY3V0ZWQsIGluIHdoaWNoIGNhc2UgdGhlIE9DQiBpbnRlcmZh
Y2UKaXMgbm90IG9wZXJhdGlvbmFsLiBTa2lwIFJYIHBlZXIgaGFuZGxpbmcgd2hlbiB0aGUgaW50
ZXJmYWNlIGlzIG5vdApqb2luZWQgdG8gYXZvaWQgd2FybmluZ3MgaW4gdGhlIFJYIHBhdGguCgpS
ZXBvcnRlZC1ieTogc3l6Ym90K2IzNjQ0NTdiMmQxZDRlNGEzMDU0QHN5emthbGxlci5hcHBzcG90
bWFpbC5jb20KU2lnbmVkLW9mZi1ieTogTW9vbiBIZWUgTGVlIDxtb29uaGVlLmxlZS5jYUBnbWFp
bC5jb20+Ci0tLQogbmV0L21hYzgwMjExL29jYi5jIHwgMyArKysKIDEgZmlsZSBjaGFuZ2VkLCAz
IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9uZXQvbWFjODAyMTEvb2NiLmMgYi9uZXQvbWFj
ODAyMTEvb2NiLmMKaW5kZXggYTVkNDM1OGYxMjJhLi5lYmI0ZjRkODhjMjMgMTAwNjQ0Ci0tLSBh
L25ldC9tYWM4MDIxMS9vY2IuYworKysgYi9uZXQvbWFjODAyMTEvb2NiLmMKQEAgLTQ3LDYgKzQ3
LDkgQEAgdm9pZCBpZWVlODAyMTFfb2NiX3J4X25vX3N0YShzdHJ1Y3QgaWVlZTgwMjExX3N1Yl9p
Zl9kYXRhICpzZGF0YSwKIAlzdHJ1Y3Qgc3RhX2luZm8gKnN0YTsKIAlpbnQgYmFuZDsKIAorCWlm
ICghaWZvY2ItPmpvaW5lZCkKKwkJcmV0dXJuOworCiAJLyogWFhYOiBDb25zaWRlciByZW1vdmlu
ZyB0aGUgbGVhc3QgcmVjZW50bHkgdXNlZCBlbnRyeSBhbmQKIAkgKiAgICAgIGFsbG93IG5ldyBv
bmUgdG8gYmUgYWRkZWQuCiAJICovCi0tIAoyLjQzLjAKCg==
--000000000000d61efc06460917ef--

