Return-Path: <netdev+bounces-77449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE01871CE8
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 12:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43B39281F42
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 11:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4718254BD2;
	Tue,  5 Mar 2024 11:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jRKa7Zqv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BECC548F9
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 11:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709636775; cv=none; b=mjVtkYArfmJfCEsc3xioDaS7ISSfWtAY/7cv7+oxG+7gzSA9e8xT6sD+5I9dz0MOsIee5/anA32yeXZsjAamxR6FmSjEoKrICFj+CBHIKf8u84rl5ldJYWrRL3n6DJ3jBaganyDzyFiU7aX4RqR3GsVksnmDKiPcekkOHOGkZ24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709636775; c=relaxed/simple;
	bh=Mu000iZMKv3zclEMUmjlT2fMuGnV5pMNcJ11wZBYFl4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=XqG4iukaXIxo+k0f3ceEAKV/6u8t0CMZ2XTNseVw5cZ4MwFiRR3IEKMYnarJTrnbJ+n2m0hF1yr7dWEmJm3jKsOnJtNqv6Ou8lnY7eeUY4GOYwu1JAuIeKEcjEHdHBzD9WfX9axJ3C1QkhcgGsjQ05Uc3Cu77TsnPvExEHHQtig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jRKa7Zqv; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33e162b1b71so521301f8f.1
        for <netdev@vger.kernel.org>; Tue, 05 Mar 2024 03:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709636772; x=1710241572; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mu000iZMKv3zclEMUmjlT2fMuGnV5pMNcJ11wZBYFl4=;
        b=jRKa7Zqv6qop8oxgSQRBVBocJo8LUcI5nGUbaKsJLL8uHbR5Rb5igz89Kpym8iTanB
         EuT+fojx2ORrFa6QlnApGUeDd1qnQMtp4pvYZrJfRLeH8TYWX79BRGPIN1VbLNxTt/rB
         +TvdTPgxyaH8/WdovBDecwhBq3Jjik7igKVaWQjGoyVQQPUIuwx7iBVzgczYKmXGvbO9
         vVqVyLTfEFvZyt4ZPWUcxNLRpEBuEeGb3ywErc9BtRrdNEeBOEpxDyNCvVvWOe+NAEzv
         CcSDC1HbW1e1TFxWotsxr22ZnY8EPjA8jqqs2FCQrPpvMhXutnoFfw3xv8ZobCg4m57N
         MldA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709636772; x=1710241572;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mu000iZMKv3zclEMUmjlT2fMuGnV5pMNcJ11wZBYFl4=;
        b=CeHBq7gaHvT68TA0MJYGwFIL3d9OdUfddTElFH/5IbR4aabOrTHL7iIgtTlwCpaY3f
         Z3Er1pSi4n4wCuCUDtu9QX31rfSiuWHIkp5upeh1Zxs7ErweQJgsV7AiGJt+ZpVHBdqH
         IvhElKEb5HTKaeBdfz8aOJ8S9sOAG+3wegZFFnPfzUSirqP/CII0j2zI6Z44xH40/Kig
         OTIL60dIo2k6utJieedxHTxKBmvj9hYM1qwewD6evbeFRvOoWgI2Mw6c8pKAtuFu2aaX
         sFnFdGDI0gbND92UKgx3IO3kyJ0tnS2m8v7xN1rkbmmI7hs8iWGxMu4YNEzqsuZWoYlp
         cUMg==
X-Forwarded-Encrypted: i=1; AJvYcCWFaGhPpDYsZwxO4S+L0xpyuBfsAZ4MyuwQjW9z41qzBRhZeqq5EVXVWjyYP8ANSjB+l67QEAZbz3LA4bMO73b2eJjWg/lb
X-Gm-Message-State: AOJu0Yw9aNWT2kOTYt3k/iTPVwE57Kos2O/1rBfPuUrgeFfn1VcpDnwE
	dggBXuBJ5+fNr2JDepwWFyYuXrojEhVNNFay035CSD26gqV3Djc4pLd/joq+
X-Google-Smtp-Source: AGHT+IF0qzUffE9w3MBzjtK2k5e3CzHtakKHnGy1KSvZ8zN7GUdwtbzDJ4vaagHTMt7z4YBbE3xIMA==
X-Received: by 2002:a5d:6891:0:b0:33d:3553:9427 with SMTP id h17-20020a5d6891000000b0033d35539427mr7365720wru.20.1709636771918;
        Tue, 05 Mar 2024 03:06:11 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:554f:5337:ffae:a8cb])
        by smtp.gmail.com with ESMTPSA id bn20-20020a056000061400b0033e43756d11sm3888015wrb.85.2024.03.05.03.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 03:06:11 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com
Subject: Re: [PATCH net-next v2 3/3] tools: ynl: remove __pycache__ during
 clean
In-Reply-To: <20240305051328.806892-4-kuba@kernel.org> (Jakub Kicinski's
	message of "Mon, 4 Mar 2024 21:13:28 -0800")
Date: Tue, 05 Mar 2024 10:56:38 +0000
Message-ID: <m2il21hrq1.fsf@gmail.com>
References: <20240305051328.806892-1-kuba@kernel.org>
	<20240305051328.806892-4-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> Build process uses python to generate the user space code.
> Remove __pycache__ on make clean.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

