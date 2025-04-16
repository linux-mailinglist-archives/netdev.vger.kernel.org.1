Return-Path: <netdev+bounces-183251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7778A8B778
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 13:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0BB416946A
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 11:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13CA222D4E0;
	Wed, 16 Apr 2025 11:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cPuFYyqB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BCD221272
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 11:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744801921; cv=none; b=J1bhFWVfpzblpx4lkz73vgmNlYVdKW4yuWXmKxMwHMGPBHQzknTLhY8yNZIFeI4SWzvMwFOiiTzzLOm8AkOyFzquOWanMwZEc4LchQOCmKQr0Z0g5wzrlCLgKVIem56FWNFamdystmEt1D6YyCcOCIDvyRROK2E2CgXVXolVGq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744801921; c=relaxed/simple;
	bh=FKmeJMfgYCjB+D9B9MWeCTSf48/JaXRoDQiPlUgJizw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=F4TWNUIiXOGyVqdBwyjUL6bIN6smAaKZZ2YDWrHK9dZ8e0Y8f2s9rOpQudvxBkVRjbEmPMvL3FYdufWL6v7fOMfl7sHD0xgpl4FlaMTYs55isHqnR3ndOoJtj1bbiecDbAuf43Zvyxhynax7AM23OPnvhohhINfg/mQgEIOXXOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cPuFYyqB; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-39ee651e419so188817f8f.3
        for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 04:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744801917; x=1745406717; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dCW5gjcHYExgz0vojGj0sgwI7z9g+RGoZwHSXfOPi1k=;
        b=cPuFYyqBQpRpYD8dsZKpgvWHcC1NPwLGDxNgFH/1DFdXmg05uDXfXbd9B9I2uY98mF
         jV6CHDkrCKighv7hSwQItbGCZVW8P3nMichafZ/6NN0W4uET/ck/niJa/pdv/0kfaBQZ
         ub2xtKwVLYaBPxMKWX1A3rGH9eSf6AhREB9g4G61OHB5ulc8RBHq68aHAhLnFfdbUle7
         yANH8YHubPfc8qSsqGG9X3sagUUm5KM6GbJMk4qYew8zm6L4X275LDXqQWsarQlTDx30
         eP55OVDAR6Tham7ppDsBeMd82gLsmpXBDshA+3FNlKfmfHz2q8VqW7AI1rKlXWDmCYgl
         8mVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744801917; x=1745406717;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dCW5gjcHYExgz0vojGj0sgwI7z9g+RGoZwHSXfOPi1k=;
        b=orPwB5ddZfWKRulxFnKJGA5sskDI2mtS3SjvXgVkDP0u4LNazx4Dy02XpG0OvxJ5kC
         usIDjn4S2D6J3d86lfYA1n6C8gm+yoNYImoeZXg9M4W8koevWos4Q1K1a8bY3VJb2Hoq
         WWi8m7ACskInMA67w2pSqVJPtVag2M6z4LhaVOJwz+AyvjrREoDJO/e21j/SA/a249qZ
         YGS1q4kzL38hKLWgUJkc0vvAARPjFZQEzyEgD3jElFurrpm0QFmO9rsS9aHIAjrUvGMa
         YOqzhlw5PvuzX7GjaKve6baJDMun11RuFh++t/CySBf4VFYBJCAXo0WEQlKX5iyrEQ4Z
         czFA==
X-Forwarded-Encrypted: i=1; AJvYcCWTDZaLkBcbcBiim6iO1821als360JI9BM0VwLeopaJdIRSpQ0KyJkqN6nVnP7he9ksN/18Pew=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIUm7T5X7Wo2GyAJdOKQaYqVAqeAVz43S8v3wJOnMcX99wqbVa
	uIcD3Xst9ovIkK51Xav4ONIogcFP/rzVaoyl78eR7Vzt0ZYlx9YNyQRJ7r40ZTY=
X-Gm-Gg: ASbGnctdeyESafLGQcqya85AI/YlqNhPD5YPyt6pslZ9rY5Uof+eC+qYU0EQYhOoxvr
	EGBDe0zbWbYMOy8VZVRTt5cx/Olxr5/2pmDE5D0CukKWwSfzzsqb43FG8748Ht2MH15jBs3NPVl
	V6ikC388I9lVLrnUmpNHpv5yDDG4pA0r0lpxcLocga3286cxVsyQWZxc3g9nCD4xtGy/L8OiYXl
	eFmO0emvTekn1qaS5SqSSb4WVeu4+Cc6i9V8DRtVJVJZ4a9vlvqewSHUu+keEXBhOHRa17klUjc
	bLYVQddjKiyng2oTbTKmObV+HMiIF+PWsPc9k/jI8mVyPw==
X-Google-Smtp-Source: AGHT+IFLY3a2I8m1IAlrZQXFVVgxEQKK6slZVGIdWQLlUGF3b2KJNdebo6Nb8tggxPByawK3HCEPWQ==
X-Received: by 2002:a05:6000:228a:b0:39c:3475:b35a with SMTP id ffacd0b85a97d-39ee5b32418mr1521456f8f.28.1744801917451;
        Wed, 16 Apr 2025 04:11:57 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-39eae96e912sm17094499f8f.31.2025.04.16.04.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 04:11:56 -0700 (PDT)
Date: Wed, 16 Apr 2025 14:11:53 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: David Howells <dhowells@redhat.com>
Cc: linux-afs@lists.infradead.org, netdev@vger.kernel.org
Subject: [bug report] rxrpc: rxgk: Implement the yfs-rxgk security class
 (GSSAPI)
Message-ID: <Z_-QeaIsAPU0n1eR@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello David Howells,

Commit 9d1d2b59341f ("rxrpc: rxgk: Implement the yfs-rxgk security
class (GSSAPI)") from Apr 11, 2025 (linux-next), leads to the
following Smatch static checker warning:

	net/rxrpc/rxgk.c:501 rxgk_verify_packet_integrity()
	error: uninitialized symbol 'ac'.

net/rxrpc/rxgk.c
    467 static int rxgk_verify_packet_integrity(struct rxrpc_call *call,
    468                                         struct rxgk_context *gk,
    469                                         struct sk_buff *skb)
    470 {
    471         struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
    472         struct rxgk_header *hdr;
    473         struct krb5_buffer metadata;
    474         unsigned int offset = sp->offset, len = sp->len;
    475         size_t data_offset = 0, data_len = len;
    476         u32 ac;
    477         int ret = -ENOMEM;
    478 
    479         _enter("");
    480 
    481         crypto_krb5_where_is_the_data(gk->krb5, KRB5_CHECKSUM_MODE,
    482                                       &data_offset, &data_len);
    483 
    484         hdr = kzalloc(sizeof(*hdr), GFP_NOFS);
    485         if (!hdr)
    486                 return -ENOMEM;
    487 
    488         hdr->epoch        = htonl(call->conn->proto.epoch);
    489         hdr->cid        = htonl(call->cid);
    490         hdr->call_number = htonl(call->call_id);
    491         hdr->seq        = htonl(sp->hdr.seq);
    492         hdr->sec_index        = htonl(call->security_ix);
    493         hdr->data_len        = htonl(data_len);
    494 
    495         metadata.len = sizeof(*hdr);
    496         metadata.data = hdr;
    497         ret = rxgk_verify_mic_skb(gk->krb5, gk->rx_Kc, &metadata,
    498                                   skb, &offset, &len, &ac);
    499         kfree(hdr);
    500         if (ret == -EPROTO) {
--> 501                 rxrpc_abort_eproto(call, skb, ac,

This is a false positive in Smatch, but why is only -EPROTO handled and
not other error codes?  It could be intentional, but it's hard for me to
be sure because I don't know the code well.

    502                                    rxgk_abort_1_verify_mic_eproto);
    503         } else {
    504                 sp->offset = offset;
    505                 sp->len = len;
    506         }
    507 
    508         rxgk_put(gk);
    509         _leave(" = %d", ret);
    510         return ret;
    511 }

regards,
dan carpenter

