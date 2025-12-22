Return-Path: <netdev+bounces-245691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 04FC0CD5A43
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 11:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5C4230155C2
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 10:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1198832C928;
	Mon, 22 Dec 2025 10:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z1kJCwEt";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="H9vmOakL"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2609F32C920
	for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 10:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766400228; cv=none; b=hYh3OQs7U4WpZN8Ykq7bYaIBH5i9U/G+wIilAee3ImZmCnAN4Dr9ZmNOZ394AqRK7vYTl39QKKHI0z1tNwxDfJPoNYIPlPGTeQV3mY0tpx7L4fGXPXExQ7LfAPFxMhjQ7ZXu55mEqBbBiMoqhKS+FcNlajPj2N9MbrHl2dguUb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766400228; c=relaxed/simple;
	bh=jTs07bqTgYv7erFfBZUMsAp4XHND0kph1dtWWouAIqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tCKjEsILd41cDPg43K0DEV9je3QyTLSE77vHe0aRg9XDoXshjbEUZtlOXW8AWuinLtNzH9LYU4KO1aZZQlnCOe0GVN6ao6s2Hf1vaxJjtt4pPFs09/baZNibcyvJTF166xN/H9zpnDCVssjWvP3dHkQdS+hIqNN/rrDZ99T0q7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z1kJCwEt; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=H9vmOakL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766400225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2jriSitIljjr+kWzTnD12aRVC8oF8L8pmUuavzP5imQ=;
	b=Z1kJCwEtZtGJYxZtjk9GMSlCd4NsXaCFM0pR8HmWQF1zcKYpQeAAJggjOnr08VZ1MTjNcP
	PCsyfn9EKIS7Evd4P3HOumRm6BVM0QknxFTGMYQMWpOHrlWFvSrBfAYc8rFJvFY1XzL/bg
	fXemFhhdHYpWEevVvpssUO8q8GFBOhI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-4Qxyhp5SMRuG2cfkzxqQLg-1; Mon, 22 Dec 2025 05:43:43 -0500
X-MC-Unique: 4Qxyhp5SMRuG2cfkzxqQLg-1
X-Mimecast-MFC-AGG-ID: 4Qxyhp5SMRuG2cfkzxqQLg_1766400222
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-430fdc1fff8so1862205f8f.3
        for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 02:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766400222; x=1767005022; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2jriSitIljjr+kWzTnD12aRVC8oF8L8pmUuavzP5imQ=;
        b=H9vmOakLBbekofEfiIqVWf/a5qslq0b/1KbebCkNYD3EoBshlBSboiDKbhG3TIBgWk
         bftcjiH2JvrpbadVznwQDSAImWKZNoxa4VvRZ/ndLRZFFzVtVOnI82mAI6v6F257vr1y
         HVlwPwEViD3kjF/cC7zM4hTNTZ5e/ppjU/uqQ3/dPHynDDmbUM9YdzYbyYUNhA5pnTGh
         WcCaWpxVgfWOQetje/hFT5COanmGYNRG0VWUAkbRoLY1JuMIzT29q/WNNLDbS2Yb45ZL
         HabjXrB6syVNvOdMSts+OczNnqUIkEkgn/jeid7n7RjfCqFWqQAGCPt5OWOtJGrHKvgh
         lZVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766400222; x=1767005022;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2jriSitIljjr+kWzTnD12aRVC8oF8L8pmUuavzP5imQ=;
        b=j2iwuDq0ynsOjotpWHjU6MwuXvb3HUqVGfAjqd2TiDXDcR6VwZDlzFQlkN0TTofbc7
         kYdxByb7WrTDisr84oWsKAkUOFBeHU4nQYXAQRYjXwp+xgBfoLPVxKl7lNbwZ1Fy1KAy
         qq9gBdfB9WhsZYW59SSF9CHdLGFmzumkF9Wor+BFgeohj7qd7tdtxNZ4mPIvUOFmNgPp
         Wn5cla2Ig/ZcCV+9jJFoAZLp/2sCpVI77FDjCXWTFmO8scza8FupoGm+mYTOCPqFmjul
         9hojcm/Hb7UVeesZ88u2Htz0yoSuhLFejKObbo3HgtVhgj9u/+n39qxDmQmKecXoUUXU
         T64Q==
X-Forwarded-Encrypted: i=1; AJvYcCUB9tLknVb0bkvNkz1bjhv0fxezFNhKoebqIUaCtO6WFMsS+AwnvsQdkJ/hJWsYQLLMFcrmBNg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx3gUpD3mDXemxZulDlOEa8KtSph+ygTdqMrMkC22EmpX1zeTL
	CGzexMCew5yhGt6QF48Qo3sNxy2nRf0p97PJMDSEp3i7hOkNz0zwp4Apdl49U7u2LzMFrr9EEoI
	xr/1ly3mUbNzow6qUwSYrB6dHc2nrEaYG7rivdgG5zaTAZU1c63X1iZPzwQ==
X-Gm-Gg: AY/fxX5XCfHD9YXdlVUl515fKpyUZZATDu3abhBhDxzhP7KE6xjtVBElyp3v3Rgfzs+
	M6MbB7YVoFjsP7k178jvtiA/XB3s5hdHo7WeQ6c7lFASgrMFQlhKe4lk2FBF8d+2Ys+zpV3Fl5A
	w0Tqegu6dzLVhexnsOWQV5jMD4V1RsjQk8eUhJT9BhWY/13MsFp2XnSyMiTlqLqRfQ4Li7opnC4
	4yeV+XOIHylNkOFFPqcytt7Oqzr2OkmZmdWc2wp9qvTFydEL2BP6JUtE6jtveAxpHXOwis/Q0wH
	x3qbEq2t/TS/c2pyMiOWn+/m3WsLYdN1XflPtSsLBM1AnvKEtFDKwnUNbowHJdVH/AdBcBSM8MZ
	QdD0HSVgpMDg0
X-Received: by 2002:a05:600c:4fcf:b0:477:9650:3175 with SMTP id 5b1f17b1804b1-47d194d17a8mr100201675e9.0.1766400222452;
        Mon, 22 Dec 2025 02:43:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHwziqKZWoCLSZ7WKnLHPBxd4RYK2XEWC3BMRdRlq9go0z1AzGbZJP7+juAwSjJEOUFpkihoQ==
X-Received: by 2002:a05:600c:4fcf:b0:477:9650:3175 with SMTP id 5b1f17b1804b1-47d194d17a8mr100201465e9.0.1766400222016;
        Mon, 22 Dec 2025 02:43:42 -0800 (PST)
Received: from [192.168.88.32] ([216.128.11.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be396c909sm92216295e9.0.2025.12.22.02.43.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 02:43:41 -0800 (PST)
Message-ID: <9280406b-d21a-47e7-a404-f494a0419431@redhat.com>
Date: Mon, 22 Dec 2025 11:43:39 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwlwifi-fixes] wifi: iwlwifi: Implement settime64 as stub
 for MVM/MLD PTP
To: Johannes Berg <johannes.berg@intel.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Mingcong Bai <jeffbai@aosc.io>,
 Kexy Biscuit <kexybiscuit@aosc.io>, Nathan Chancellor <nathan@kernel.org>,
 Yao Zi <ziyao@disroot.org>, Richard Cochran <richardcochran@gmail.com>,
 Miri Korenblit <miriam.rachel.korenblit@intel.com>,
 Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
 Daniel Gabay <daniel.gabay@intel.com>
References: <20251204123204.9316-1-ziyao@disroot.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251204123204.9316-1-ziyao@disroot.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/4/25 1:32 PM, Yao Zi wrote:
> Since commit dfb073d32cac ("ptp: Return -EINVAL on ptp_clock_register if
> required ops are NULL"), PTP clock registered through ptp_clock_register
> is required to have ptp_clock_info.settime64 set, however, neither MVM
> nor MLD's PTP clock implementation sets it, resulting in warnings when
> the interface starts up, like
> 
> WARNING: drivers/ptp/ptp_clock.c:325 at ptp_clock_register+0x2c8/0x6b8, CPU#1: wpa_supplicant/469
> CPU: 1 UID: 0 PID: 469 Comm: wpa_supplicant Not tainted 6.18.0+ #101 PREEMPT(full)
> ra: ffff800002732cd4 iwl_mvm_ptp_init+0x114/0x188 [iwlmvm]
> ERA: 9000000002fdc468 ptp_clock_register+0x2c8/0x6b8
> iwlwifi 0000:01:00.0: Failed to register PHC clock (-22)
> 
> I don't find an appropriate firmware interface to implement settime64()
> for iwlwifi MLD/MVM, thus instead create a stub that returns
> -EOPTNOTSUPP only, suppressing the warning and allowing the PTP clock to
> be registered.
> 
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Closes: https://lore.kernel.org/all/20251108044822.GA3262936@ax162/
> Signed-off-by: Yao Zi <ziyao@disroot.org>

@Johannes: I think this patch is already in your tree, if so, can you
please share a PR with it? there are a few notable users hit by such
warning:

https://lore.kernel.org/
netdev/221ba5ce-8652-4bc4-8d4a-6fc379e32ef8@hartkopp.net/T/
#m3e671c8c9a482d90a6fa81e953af723af5546118

Otherwise I could directly apply the patch to 'net' before the next PR
to Linus (on ~30 Dec).

Please LMK!

Thanks,

Paolo


