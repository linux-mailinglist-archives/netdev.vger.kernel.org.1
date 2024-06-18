Return-Path: <netdev+bounces-104324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B882890C287
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 05:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DC331F23606
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 03:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9430E1F608;
	Tue, 18 Jun 2024 03:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PEsqI3zg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0F233C9
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 03:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718682001; cv=none; b=L6Qt5YSLidBerqTOXAeYbceqRDoFX/uc8mjyp7eBmjwaRkKCFCEqAFXMjCHctqTCHrh0/ky7xuRmECjykG9pjd+h1BKoFw+SIs5K+x3GtTVJkjL3W/Evip1S77HEP2lLAKEIUpRDlX7G5MaYA5e/4dGej/buojauFHQ+zZqDcaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718682001; c=relaxed/simple;
	bh=9R5qE7FafXFWcD3Y7z3iIT+mAAL+wGDeuoJ1GBqXloQ=;
	h=Message-ID:Content-Type:MIME-Version:Subject:To:From:Date; b=Xy7XY0eNB3UHGTVDeUeozizQLDMmroIbgb27LThjn1TBvd3uN++kc0n757LK0jkRkclDfmRVOiiyBZNOsPnf4AX8kyg6asje4SOxNTVcMJe6/lbx/enQSV1q7QHXv/WDw10qDrgoWof+4b87CZibbYgoZBP8vEvYdyihcoU/8xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PEsqI3zg; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f64ecb1766so35777005ad.1
        for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 20:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718681999; x=1719286799; darn=vger.kernel.org;
        h=reply-to:date:from:to:subject:content-description
         :content-transfer-encoding:mime-version:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JW9JdfGLqOA4NGYBBHM4huoPyhwwf+L1YHH5/lx/LMk=;
        b=PEsqI3zgcmetV3tflUdZ0GqXY+WdJgPoI2/BntoZx70lm6MVGU8UZ6F/L181hjqEjp
         HAvKOMlbWgLZp8JNEFDO/NtT+W7JhTutZE/2mwH7OetQ7C5hjylqaztqfi1gyndwLar1
         6hfI/x4Di8hGecXo1w6BthpBXl0fbHr+UtPxxIzELLOPkWpqrTTjepPbJnYpP5GIJyWI
         GwtqNbNdkpMFtgzcJO4ZCV6B38JBoLcQBmiKvplzlXi29tLVYSGepZrRafE7qp6dUZpH
         roPDfV2eDs9hg3jDcooa8XbBaU7hUao9nSYuyRgbg3Rp9YGUKar3fNW8B2ehPP89ItiV
         zxnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718681999; x=1719286799;
        h=reply-to:date:from:to:subject:content-description
         :content-transfer-encoding:mime-version:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JW9JdfGLqOA4NGYBBHM4huoPyhwwf+L1YHH5/lx/LMk=;
        b=KlRkpj9F8Oosp6XzYuhZfrrDWtct/GpMuRUW7SpFblSilp90pnQd4aFzqFa7n5qS3C
         KWdzdvCJchLVvpDVJtaOoLdQZ4cWsQhElKhM/P7/2kGmtCxLslmgU4TFNEK8d0nR7op4
         drT+4iOPkBPjy/KEjzoPd0vU9uwDJW+/dGCwCFA9J/JSM25b9T7+kDttp7mwjIpP9eVN
         /X5wIgzYMn0bbIFdOPhIzrBkB0cCKvNcCwVxENB5XvdHavWTPbmow6/qdQm5C2wLaU7S
         6QkZDDZZ7BW7zXeK2Ucmscd/efO8ca60zdnTX34uFMiM0wy6z/taIb4HVg7zrjmkMpAU
         pXCQ==
X-Gm-Message-State: AOJu0Yz5R0i0GDk6HCOppGghlnfAuwz2Ov0FQ2dfwdqLUhF37GB4U+Mb
	OAal55+iV0e7g9E+qTxmao7GboCbE8UQxP7gPHSXusl6hNDkzq7yT1vH6CtaYU+ZcQ==
X-Google-Smtp-Source: AGHT+IGk9JbZpSdsUAIJ3j0mRbSyRLL/Rsg5fes+dUD4OMjovImiptXW6bh45k75BoKjJPlqc4BHkg==
X-Received: by 2002:a17:902:7612:b0:1f7:243d:821f with SMTP id d9443c01a7336-1f8626d28c5mr89139115ad.35.1718681999281;
        Mon, 17 Jun 2024 20:39:59 -0700 (PDT)
Received: from [192.168.8.100] ([203.144.86.123])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f31b78sm87085415ad.258.2024.06.17.20.39.58
        for <netdev@vger.kernel.org>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 17 Jun 2024 20:39:59 -0700 (PDT)
Message-ID: <6671018f.170a0220.daf7c.7f7e@mx.google.com>
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: From : Miss.Samaan Nazira
To: netdev@vger.kernel.org
From: "Nazira S Elishat" <shankarhitasoft@gmail.com>
Date: Tue, 18 Jun 2024 10:39:56 +0700
Reply-To: cuvha4v@gmail.com

Good Day,

My name is Miss.Nazira E Samaan,the daughter of the  former adviser  Samaan=
 Suleiman, to former Syrian Minister of Oil and Mineral Resources Suleiman =
al-Abbas.I sincerely apologize if the content of my mail is contrary to you=
r wish, but please treat with absolute secrecy and personal.

I am looking at possible cooperation and setting up investments worth of Mi=
llions of USD.I need your collaborative understanding to secure the funds w=
ith you for the investment. I would like us to have a very intellectual and=
 comprehensive discussion regarding my request. Your  attention will be ver=
y helpful.

Let me know if I can send you more details.

Regards
Miss. Nazira.

