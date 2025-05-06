Return-Path: <netdev+bounces-188329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 887FFAAC336
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 13:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9D2E5073EF
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 11:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62CB27CB2E;
	Tue,  6 May 2025 11:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="dTiLF/vD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A7227CCEF
	for <netdev@vger.kernel.org>; Tue,  6 May 2025 11:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746532752; cv=none; b=nhtyCMu8wpIO1fP6aV2C8eRhXxdn1SpUfiTnFmRW9Ela5+hU+6oUnKtZLVcz/ewxXrSr9fJcS0JfKzyTxfe0I3te3hB7KqchxZNnW47zjP4RY57Zb29n6m9Tdx2bphe7QuJD9+FQ4zUFokA3/Si/TguqELj9oWgrmdjXrBa5Chs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746532752; c=relaxed/simple;
	bh=NyqlLtehw6NEZwHZhrtwtvudG/4S1rt+vJ+01aCwitU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=YJWbe3fCy8FNRMtOl5KYAX5W2bClWCITpw99yfruBmukCE6VkoReh600DTHazZ2J7jN3l2xrYLJKE39PZ/mWaEkHZY9As1feXXS6/onE49cMSu0tfNfINrmZlfeC4VPvPKQtsXTKzd3gK20VWbajJ0OXwCExwldUqtjW+oeqVWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=dTiLF/vD; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-73bf5aa95e7so5224195b3a.1
        for <netdev@vger.kernel.org>; Tue, 06 May 2025 04:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1746532750; x=1747137550; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NyqlLtehw6NEZwHZhrtwtvudG/4S1rt+vJ+01aCwitU=;
        b=dTiLF/vD0QZLiVUo/vLoEArK8s96RVwwsQad9Ek4iBWNH//nK4AC6UTKgwHFfTba81
         zp1HMTnQoe6nx02qJeWRc+wbokqZfH5SHTGYR05FEj6TxWhFPf/Islf+cjRaRRy0O99f
         NtGHL40HRcA9lAIFoNWn14Jjpbwi0yNF49WCbFi9+v1bpkEBZT6UEIeWBoPV8EeA4cmW
         BjhJzpBkMD04jPaay2chMKfT7oLC1KDPV9cmbS5BAC1XkVQSeohA+Vr4DcamuF0AeOf1
         pUqhkVXgtrm6Cpl3JF8Hm+ptZQQMHQMSjsyoPmXfzCHYH3UuotToA+CA8neZmmx1waLt
         wkCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746532750; x=1747137550;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NyqlLtehw6NEZwHZhrtwtvudG/4S1rt+vJ+01aCwitU=;
        b=FlPzjnva9nlz9WfshFUF8jjHWM94POEaVZkfD12xpnmTul+uhwpWcdwAfUIh+WD67n
         LnEEEDGxnsdayVTIDRkCzBzw/pO8APmnqb1VrnMya6kBIgw5SbZZSgLpypaQzKxvaFB8
         NPX6df3KAskrvYEi5JK4CA2DcLGLC3dS0QtgiH1dwn0aTjy2mgPIz5l2yoZuoYFGfFha
         fnFI+yS9fg20klxFzax2OJQ6EDB2AKAqN2b4UoT+lADYl033ga+dHDxptaXb1o7BMU56
         zTHyg13AYZz8y4z37F1WkTRtMQfxRNpgtEKm4JGX1vKQMI0q5jWL0+svMQgOaveXg7Er
         CVew==
X-Forwarded-Encrypted: i=1; AJvYcCWe67oDQPeiOdmnMChiqZFXzUCccvbn92ewPraZHYN5thWznZk03EUJapPHB5yrpOQwxteuAfI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeGaguuz92TFSHWm9Nd9veobsZd94ke+vUJ106OJrl0qajZ5kE
	nhb/6Nasu7MEuc7h4COkRsF2Eyv+f6Y0gkCGId3FY5AG8DwHfJNCFro3elXDm7XEP3R4Gom3GPK
	kcONRxA6qVeeTrJxubzS8j2s+Y91ny+Ti2C7G
X-Gm-Gg: ASbGnctydpz9qUQp9lSzaDgK+RyTjwu7GvTpFXjBRVM7H2HL6tC14wsTrF/J4+9EBKL
	FPEpfqfj+Mt8VI932EIRt9YWhpCbnJKtan0Fnhu4rBMimhxpDJsg60Yv43zfBSgWPWNHSIQ8ddZ
	qn0QPLnxF/VmuZ9Yrqdi8y
X-Google-Smtp-Source: AGHT+IH6C/0gFATwnZjsJhbxrm8TTvV5eoVuZpAaU1+U/3Qp7nKP9FlafeyEQWCCVx80cUFCf/4eCpYmdRIlY6BBgno=
X-Received: by 2002:a05:6a00:410a:b0:736:a694:1a0c with SMTP id
 d2e1a72fcca58-7406f1a3c57mr14800393b3a.21.1746532750370; Tue, 06 May 2025
 04:59:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 6 May 2025 07:58:59 -0400
X-Gm-Features: ATxdqUGK0ZJBoMWyZuod1iyhP7hESb5eVicVgHc1O5BqtxAsguzHp6UUTdQwdfw
Message-ID: <CAM0EoM=OSi8njcK5aLUVKRNH8TxQKfx_y=iXQZ2ySaTccuBtaQ@mail.gmail.com>
Subject: 0x19: Slides up!
To: people <people@netdevconf.info>
Cc: program-committee@netdevconf.info, 
	Lael Santos <lael.santos@expertisesolutions.com.br>, 
	Christie Geldart <christie@ambedia.com>, Kimberley Jeffries <kimberleyjeffries@gmail.com>, 
	Bruno Banelli <bruno.banelli@sartura.hr>, lwn@lwn.net, 
	Linux Kernel Network Developers <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

As the subject says: slides/papers for netdevconf 0x19 are up. Enjoy!
0x19https://netdevconf.info/0x19/pages/sessions.html #netdevconf

cheers,
jamal

