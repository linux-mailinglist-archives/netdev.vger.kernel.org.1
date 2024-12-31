Return-Path: <netdev+bounces-154620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E52ED9FEDF3
	for <lists+netdev@lfdr.de>; Tue, 31 Dec 2024 09:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E825C18818FA
	for <lists+netdev@lfdr.de>; Tue, 31 Dec 2024 08:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5FF18B482;
	Tue, 31 Dec 2024 08:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZhQDqlY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FFE7346D
	for <netdev@vger.kernel.org>; Tue, 31 Dec 2024 08:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735633485; cv=none; b=tTG0ISG+/zPunSGZ4qmfQ7tlmdrQTaV6wyOeTDCCJxUek9f4BOvHSEu5inD/HSLk9wm5jiflNIIzMtc93WGJgPLnz/10mpabrsZfyNj1KMHnHO+V5mLjZS/Q+dEYfSJeFQaZFATd82tBmH3kGE64NJidg7Q4aqcUOrUAv/q7eoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735633485; c=relaxed/simple;
	bh=boAkVgwDkDq86GrtDZcXNju34b+vULme4fgGVvQ3IKg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=VFeKdwN+T3Hoy1ydssst8OhrhZ12pyRw5bF9XwJdkPG+pxg0irD2rMOCFdTNLQLmEK5otFTjps8VahYZIg3pxooQg7KURKCQRzV1KsnDIDgutM6VssvWAHAmhtBhV5CKO8dG1pBHUXrZcjuVLNIALQHF2MqtT8OAx1/I93LadJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DZhQDqlY; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6dcd4f1aaccso13593736d6.2
        for <netdev@vger.kernel.org>; Tue, 31 Dec 2024 00:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735633482; x=1736238282; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cpnSDAjRDy6pJCC9eyTbrQpSlLZuHJWfxitQ0oNeIFE=;
        b=DZhQDqlYWxEVoI38cWD0lKlhjbrw51MnTzqZhB3sanCafO2DuEEfYmWp3aleCT5e0S
         n+SrbnRcnRsSgCFdVH4kAoarXZzXCTwjq72Vhy+Y3LgDEU/wtT6JvdFMxUeUEn7jRye+
         EHBNMZ6VL3ztBJpLK9i04VtJOFVay5kR96eNZB2p8VI3RpDTg0EJZCv2KaN7/lqr87B3
         DOjSPPBZjbS9sKAwWrOAvyZwYi5b7C2tC7T+0z1WltWgTUIuUBOdcT7/SfxYSCblJNSB
         HNh9a1Zv/lLknk9LFEq7/c0HsbHElOmWezpnOUKBZ5nGanbo7xg2ZTHHnM5Z4ppUVVPn
         3xqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735633482; x=1736238282;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cpnSDAjRDy6pJCC9eyTbrQpSlLZuHJWfxitQ0oNeIFE=;
        b=faHMJqri5HsGlKGkC2BmLrpvfrOdDYbg22tcdkBUBppPwxNExd3zD8/HJDzp/WATU4
         5PwpZg1SF68mK7cSwsCmOmVcMefvSOyC8NE/alTjxiF6Nl9LXj+g9TvK/t/yQiyuFagi
         he0lU6iz1FxIN92ZB7DHaYYnAQB1j5YRd4PcRoXorEpYpZ2TlsGdpFXANsN5bebnFtAq
         8Gy+wFBP7SHt1tdqVFAi4bXTIWwENwHUaneQNAlLCUF7sSwI/6NP0d6yD5laHl2+lBa6
         WWApx0zLTl27aXdN7ZWpiBdl73SLj9loc66vlhD9iQY/A2PgdwlUNOkMwJeauMxBbhTN
         W6Mw==
X-Gm-Message-State: AOJu0Yx4vxEuAs2lVRaC9jJWAXIDCNgLhFBsTlr7Hg7XxSf5DuiYxod7
	kFAbUf2lRpZGIftkmAjeFPJM2Rh+x8UXIIB8tMbMOd9MbiMefftHfp5qTqvY6RWVWXoTOYIEcHB
	ZjjYgIffP0q6EdKhC3ZoZPItHIE0O48QucXQ=
X-Gm-Gg: ASbGncvzJ2iGtaxTRsnwtS5/VV+FU82K09HVr184qt4H9FKPCDIGJrSLl/kQHDLJShY
	u94HLAmhlhgRb/XrS1sPTRjNLiWu+opEttEmgXA==
X-Google-Smtp-Source: AGHT+IHbw+qWbNzIjeVcFllVI01+Re70nM6qbcEXiS1YYOcH1w5p1aJRH1u8q8IwjzPYUueznJ6thW2j8Jss9UbBSJg=
X-Received: by 2002:a05:6214:519a:b0:6d8:9be9:7d57 with SMTP id
 6a1803df08f44-6dd2338c77emr576645706d6.37.1735633482445; Tue, 31 Dec 2024
 00:24:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Zhongqiu Duan <dzq.aishenghu0@gmail.com>
Date: Tue, 31 Dec 2024 16:24:31 +0800
Message-ID: <CAFmV8Nc758FDNK3FNSLQui4RmE3-TQr7d2tM_tOM6bC=OfEDwQ@mail.gmail.com>
Subject: perhaps inet_csk_reqsk_queue_is_full should also allow zero backlog
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com
Content-Type: text/plain; charset="UTF-8"

Hi all,

We use a proprietary library in our product, it passes hardcoded zero
as the backlog of listen().
It works fine when syncookies is enabled, but when we disable syncookies
by business requirement, no connection can be made.

After some investigation, the problem is focused on the
inet_csk_reqsk_queue_is_full().

static inline int inet_csk_reqsk_queue_is_full(const struct sock *sk)
{
        return inet_csk_reqsk_queue_len(sk) >=
READ_ONCE(sk->sk_max_ack_backlog);
}

I noticed that the stories happened to sk_acceptq_is_full() about this
in the past, like
the commit c609e6a (Revert "net: correct sk_acceptq_is_full()").

Perhaps we can also avoid the problem by using ">" in the decision
condition like
`inet_csk_reqsk_queue_len(sk) > READ_ONCE(sk->sk_max_ack_backlog)`.

Best regards,
Zhongqiu

