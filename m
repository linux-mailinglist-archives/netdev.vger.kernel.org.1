Return-Path: <netdev+bounces-272031-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKAJE+4pxWkU7QQAu9opvQ
	(envelope-from <netdev+bounces-272031-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 13:43:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D5E335631
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 13:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C825D3045BF9
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 12:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7111A3F660E;
	Thu, 26 Mar 2026 12:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OuJOITzV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347543F1661
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 12:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774528899; cv=none; b=MSitN8BChOcalYVQ9WiL1V+5Y2kGhhMQC//9JX2BZVnzY5JiMTkKV+ySiFLEVdxT7FT4X0AvnbRMN0oVKDOz8qHP4CFvR+4f9AUk/JNkZM+VzrkqxTRnFEskL/oxgTp3noJexiJhXgnUGZELAfXvKzcs/xp1KYDMAgMOawd+KOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774528899; c=relaxed/simple;
	bh=cJLybKtA7qZVchhZpSmIkgEGEIJ2i8skCN64+TWywC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s8BdDYI9QCoI5HXRHQdL1WhnGkXeBD1gmcomLOuIkpXdU93h+LyYhR/mEay3OfzkXvFPRr/8EXgYYktUX03FyP8Yjfx5PJp5HcjHAvH1Lt939MNoptNJvMwNdVVUI4oBoI05PC2xv816jlv4jZ0uoRK0GCOrTvAawspt8QReAWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OuJOITzV; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-82ae378fff8so643407b3a.2
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 05:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774528897; x=1775133697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GRSZw6tNZSgMZnXBuoH71ptYXvDvECtHFGr/c2qVkiQ=;
        b=OuJOITzVS4z49PZ3GSdAGYlahVfLmiXk1qoEJhB1ulQPGQpic00UWneT0HggdKnWNz
         3RwpltU/vboH8/LNFUjRgpnQYm5sDA6wSZLO7wfcqInGG+G3gs+AzgMJuOC8tqTQTzGl
         6vWWbAeZZiuHk7oauDOxhPsFsw3wH8N9cHye3jM9mbLY0FgV8tObudxjOwglH7bbagZu
         RbOCONdnvc4TEadj/SkO/vHXozFdoPNtWnZ6Msq72+Ewlv60yqu2u5YTjZs7FpxHZ6Pm
         fbV5uQVF59vVu/cI40DN6VWDdXBON3LNsjcFZ4K+/EQBOqVGFespRei++EMZz5Z9i97f
         o29Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774528897; x=1775133697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GRSZw6tNZSgMZnXBuoH71ptYXvDvECtHFGr/c2qVkiQ=;
        b=cnjfHiG5BVWSzoTykAqxJImatBWdDqsJZK5Z1ollKtLNXi+eptKNpFe58hxUdiZeX5
         GiuyWxozOw7bB1KRc9kAGsoefaNgWA3utNC9y/PpNBGe+lnpECIA/vAnlSWzLmy/ROZv
         1fXNmpPGyu9zS6GXjLJQ7ekHAn26DIuE5bj7jc4UXc+kvDJ0OBDut//4qwQCK1x1RCgN
         PdixK3Aj1foPM50vkeveKXWxqf+NuyGVZT6vTtk7YBz4+0pUBiomiE13bAjfJu9d+G5v
         IXJHyfIQHe1HeaNOXk6eiKTYnFBZrvnmRD//drRYbpEEKuxA0y0Z+B9An8Uq1u1FUIHX
         TpYg==
X-Forwarded-Encrypted: i=1; AJvYcCWwV6x5JUM4/8OYQvNy1a1qa4cqFCnDTWsygf0EM3NkmAt/VE2cC04ckMY/x892u/EqfD+QiII=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbcmVaxXuARKFEEjnWUKomEZ5JZ0wt9besA/JVRyZ4/LB5gGQR
	yHPuTjckBmFlaAYRoPdiKsxKTwXyX+ST6O2Fius/Vuwm6gwqsJpMOWd/
X-Gm-Gg: ATEYQzx9nLEvENAejlHYE/wnrZeJxPyJHEb6+UC8MaJg0e9R9aANh1RPfGkzaZRQSPR
	WLOe1pr0iYe4l29akltnX0xbodzrLtWRfPrtDIRB7UleE/DsaDSPq/tbjSSkyecrYGBp6dp8cnm
	npn/KUDWO5rsqsHTlgtO+drTuKwVPW51AGrbiKOYNNWgX+GybeI2OxNrSjbyMnzwBTXOZ942PaC
	qOc4Dm2Zez0/I/kND5dn4JjlIl0RE8pLj9VIsbtMl5JjaiUbhsFPX6aawUvkou7nR658hMFjTIs
	bVZlX6gIQJI1sbLnOul7WFh0/9xuBEiZNaBKSg46nMKAQF2N1/QW1tAwrD0faYY7xfTTUw9kZsz
	EQpOqiDOgDspZ9AH+p9lKcejeqz53CZlO6Ed3IDSE+av/eX8+/W2dTA6ZYsjj4GKbmJejMcSirE
	V7xBcCZop8lhEYBJ1dL/tUZ5uAt9Z+QXCUKp4=
X-Received: by 2002:a05:6a00:430b:b0:824:93df:6d86 with SMTP id d2e1a72fcca58-82c6e0db5f8mr7181255b3a.50.1774528897356;
        Thu, 26 Mar 2026 05:41:37 -0700 (PDT)
Received: from localhost.localdomain ([114.243.117.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82c7d400f62sm2446514b3a.55.2026.03.26.05.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 05:41:36 -0700 (PDT)
From: Qi Tang <tpluszz77@gmail.com>
To: steffen.klassert@secunet.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	herbert@gondor.apana.org.au,
	horms@kernel.org,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net] xfrm: hold skb->dev across async IPv6 transport reinject
Date: Thu, 26 Mar 2026 20:41:31 +0800
Message-ID: <20260326124131.193796-1-tpluszz77@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <abz65sB_1I9ImMx6@secunet.com>
References: <abz65sB_1I9ImMx6@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272031-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tpluszz77@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E1D5E335631
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

I reworked the fix direction to avoid taking another netdev reference.

The current idea is to reuse the existing dev_hold() in xfrm_input(),
carry that reference across the async transport reinject path, and drop
it only once the skb is either consumed earlier or the async reinject
callback has completed.

Very roughly, the change would look like this:

  - in xfrm_input(), do not drop the existing dev reference immediately
    on async resume
  - add a dedicated queueing path for skbs that already carry that
    input-side reference
  - in transport_finish(), switch from NF_HOOK() to nf_hook() so the
    ret != 1 path can drop the carried reference when the skb is consumed
    before okfn runs
  - in xfrm_trans_reinject(), drop the transferred reference after the
    callback completes

Something along these lines:

  diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
  @@
        if (encap_type == -1) {
                async = 1;
  -             dev_put(skb->dev);
                seq = XFRM_SKB_CB(skb)->seq.input.low;
                ...
        }

  @@
  +int xfrm_trans_queue_in(struct net *net, struct sk_buff *skb, ...)
  +{
  +       ...
  +       XFRM_TRANS_SKB_CB(skb)->dev_ref_held = true;
  +       ...
  +}

  diff --git a/net/ipv6/xfrm6_input.c b/net/ipv6/xfrm6_input.c
  @@
  -     NF_HOOK(..., xfrm6_transport_finish2);
  +     ret = nf_hook(..., async ? xfrm6_transport_finish2_async :
  +                            xfrm6_transport_finish2);
  +     if (ret != 1) {
  +             if (async)
  +                     dev_put(dev);
  +             return 0;
  +     }
  +     (async ? xfrm6_transport_finish2_async :
  +              xfrm6_transport_finish2)(net, NULL, skb);

  diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
  @@
        while ((skb = __skb_dequeue(&queue))) {
  +             bool dev_ref_held = cb->dev_ref_held;
  +             struct net_device *dev = dev_ref_held ? skb->dev : NULL;
                cb->finish(cb->net, NULL, skb);
  +             if (dev_ref_held)
  +                     dev_put(dev);
        }

Does this sound like a reasonable direction for a v2?

