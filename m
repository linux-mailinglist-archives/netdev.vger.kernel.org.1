Return-Path: <netdev+bounces-168219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B596A3E271
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 18:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B59A81885DF4
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 17:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621FE1E2848;
	Thu, 20 Feb 2025 17:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D1THuDW+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58A520485B
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 17:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740072433; cv=none; b=Zc/nhqrpLJbpzJY1b3ne1c7nPY9xcSFS3Fe1Ooqgm2QuTorDXEnPrc+zY4dTlT3maou2XA/fHLT5qUs6irvD4whJiGygACtuXOvPGYnqIH2kYDQa/VEDqCjcwwcTpDUqH1O+/TcGEBydKiad0pGCdQRgSuxYxmZqPte/fK155mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740072433; c=relaxed/simple;
	bh=vRplkjO3vNoETJJy67dL67WWW9cIguhkiv55gSwWyTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ROfkN+O0nMrWkO1yKG7knRt213RnclBwIODjudE/WqLZqXA1+yJIjiz0d2wwKbF1nAX09SNdf1gIdggR4DLdscYZmmXRafrtbda9ngRUDMjSHv+Nf2uHnXjo4UCWM2C1pilTaZPfg4q3+pmSRXicnRVRUaPduR4kcPjccLdEaGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D1THuDW+; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22100006bc8so22014095ad.0
        for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 09:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740072431; x=1740677231; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NAu83tvsnhKq7ieBga9cU/fsnN60sOJihyn4v0OdqN0=;
        b=D1THuDW+WQGudar8M7Oams42M+44kSYyT59JwrM+vorO/4KZcs5AfkKQRSoAKUIvH1
         qjeELY8YlNt8JiZ6U1BEqtaOqLFHbgW0rgL1TSefICg+tJO5gs/eBsteExP7PE0IfYLm
         1eINi+s5HFGRN8UQfEINXX5RYEsrzl2XGxVF63i0RJ6Qe9OGdC3W36Yo7hP2hH7aDy2D
         +wlHF1nwmF0dwW5r9xQKGImO/XXKnGho1PkUWAHtbcphAKcBAo6Y6g0hmpthq5NGGnme
         62wD609xL40lutAn3RHVgmTTi8wBxmnbuDOzgPzHKInys8pAdmhJoKVHJiN9QVXG1sbs
         1nyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740072431; x=1740677231;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NAu83tvsnhKq7ieBga9cU/fsnN60sOJihyn4v0OdqN0=;
        b=NTi/xtcAwYXRK06nciHlijp7GkAR646kxKV8tlsdk3m2ONXvoMOlTLLMMmYE9c3+Oo
         jQEhIYmJMjSRKUoKAj/ofCMIjFaOhizscuIKHqsZmpYOmQWnJHQX7sMqATMUU0fND6zg
         iWS8pxUu+9D7z454phHRwDvpBwq6Hi2h+6tclzpMYjdwrTs3old0GHdPLQ2ILOijOfHX
         usrDBMOYNlY1BrKAE6GwNMrthUx21grRCKpD/a1IVyAIjLRYLIGchoMIO7Nhnws5M6yu
         4wl2193lyaFMn2pIlKfJO0pwTSXFCtf28ljPydthjRhefMfckR1vFtR2KxmWvQc+IJp9
         eQkA==
X-Forwarded-Encrypted: i=1; AJvYcCWRXHlGYtC3qUT7TKSfc5WsnUUVbbEqCHvV0D0R6GVE44HXoc/7w55XMRsDa+Fc9nseLlpSO70=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzro60Y6oMDp2budRsHu4WqC1gCk1MfaYMMplqNTX1QgjrlMlaz
	xUZ7OoOvDlJUr75JyWCVl3wsbo9evWp2RYTk7mqjiwBMJ32CJt8=
X-Gm-Gg: ASbGnct/V61uNfvYmCCumfOPFWTDRWHHSs30HohBpA1G5Rkzv5eDtjHSWb1+aAgHTtW
	p7Gy7ebHgAaM6GG1ufBRJ1ApOKBKEOOSHPoexbAG+SO3pQm4WKPZeAlD1OoxjFw0aZHSTZcRUiI
	Fhl2KxrWyGafPcN0Ra2JNQf+gwPCN4sLJijXxEUe1/KivkkLMVP1DIlW40/b77RNiejI1RgUqu7
	i9emADWVw6Mfb2kmgd4y98/U2PraMMXm9Gyif1QrjduOfUSO5woUXJr8TAtL3UOlUFEYl+07oHq
	0uU2il0WkgnlbiU=
X-Google-Smtp-Source: AGHT+IF1Ebzyri1t6cwdjCzORv1wNHmr1U3p0BzJQq6q4stA3c0Cf5lLFaBUcQc2zghHkGf0Dvo1lg==
X-Received: by 2002:a05:6a21:7314:b0:1ee:e785:a08a with SMTP id adf61e73a8af0-1eee785c6f1mr5434002637.29.1740072431200;
        Thu, 20 Feb 2025 09:27:11 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-add21f2149fsm10682082a12.1.2025.02.20.09.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 09:27:10 -0800 (PST)
Date: Thu, 20 Feb 2025 09:27:10 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	jdamato@fastly.com, petrm@nvidia.com
Subject: Re: [PATCH net-next v2 4/7] selftests: drv-net: probe for AF_XDP
 sockets more explicitly
Message-ID: <Z7dl7lBSya4EFYhm@mini-arch>
References: <20250219234956.520599-1-kuba@kernel.org>
 <20250219234956.520599-5-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250219234956.520599-5-kuba@kernel.org>

On 02/19, Jakub Kicinski wrote:
> Separate the support check from socket binding for easier refactoring.
> Use: ./helper - - just to probe if we can open the socket.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

