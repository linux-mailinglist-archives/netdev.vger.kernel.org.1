Return-Path: <netdev+bounces-271299-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6H4qAID6wmlXngQAu9opvQ
	(envelope-from <netdev+bounces-271299-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 21:56:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 76EE431C95D
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 21:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78C9B3112784
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 20:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19EEA35F193;
	Tue, 24 Mar 2026 20:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxkmaBfi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3D935AC1A
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 20:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774385594; cv=none; b=jgkU8R54FgNo4SxF4DtSvMGD04tNulWQ+/Lj0ZL12xpHXsynEbATumfPaJv+/E+WDX1upKoC1MWQdjYC48jPNrTNX0rQVJeKvq9NuA3MT9rA+1CI67iIxCSONmU7z5QtqbzI4wEUeSBheB+zizrAkC6BDVNFq8dCDyENXG4BaV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774385594; c=relaxed/simple;
	bh=4QGpcwp1qxPVf6ZUcecn/0yfhjD9Mu5cjlL/DeSgN9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q4r8Kou2pOFX9bdyvGTcs/ymZssHKE1a7BL+axi5D7wBD/zCgXB/uq3wdF8l7KH1j9wxgoNwRHb0spemT9JRrgU1P3fG+dYiMZ+sYUAuTK+aa4ygXv/RKj8ugRWLTEZJvZRev3xhHerMVkYdYf1Tg+ybthxMK4SelaikZk15IQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mxkmaBfi; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-66f747175d8so981916eaf.0
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 13:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774385591; x=1774990391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JBlpY7eubv7wZkuI5bb1efaRXZw3P7J6opPPvgxaNtg=;
        b=mxkmaBfiiys8Bxyv1jLPrcyliG/ecgKNNJ1J+m7TW71vVzX9cWmytPhu+6OVwnE3e8
         MyrZIV/B9MNEEBbAcuQg+Id4eokapaXXU54U/AYcPf7nvklixqEwmRbGBLICqq0Zc8QI
         qOyBHiUZ5FaYcw/GM4op/gnV5RBLERLpfIewwa02qrtsu12YnSje3yLTGtN4odoo6gor
         EnIth+NejuoivYyZccISs467oWk2ywisEJgnKkFXcrOYiJ58kM3FrmXEARrFJJ0F6c/D
         sgpE78gr5ak1ANM2TrTUYPxRZW+JZ8sB4k+P66tV8Gi6a9OPYC7Flb1VWq6EK04dOOR4
         2M1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774385591; x=1774990391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JBlpY7eubv7wZkuI5bb1efaRXZw3P7J6opPPvgxaNtg=;
        b=nRHbGMKXdlltUHK5+gXz9V4ls1oevFX22MWxokDAb8x1Hq/wjN+9SEWwz+aO1Y69ra
         NYSy/gz1ialLYYa5CAW7E2rk2EduDl+osSj63Dnl1YFSywzijhTzjP5Mc1KvY+B4K2wz
         cKkYSxQAnURH/00rbg3F9tDOA0SclVoek4657g7e9df/GDsFCldp3A+1qRzrn6snU/DC
         IWYkF/q67PPqfR2bU9Q4LE1+zuUOlg9vpDOZaVamhldNf/IDmONIaVsxcgH9N9h3xVBp
         ggLl4x4/wSP+DO9h0QgSwZW9meWxulwAZTHU7iR+SoZrjcgfatIvOhrQRubcsQjMV4Vs
         d6Rg==
X-Gm-Message-State: AOJu0YyY/bNFa9DADodLTrvHM1jjIgVcmlW7Fl5aX21/r3JS0HS0OEYR
	Hc787didQ+dTKbznkMByfgymOh5oPuZnA3kbvRrbarJaSwj3C2MrypFqf11eKTPa
X-Gm-Gg: ATEYQzwHEz7gGm0UU/R2obb24MAdrJ0r/yon6coGfyYr9blEyX4R7FmLba0jRbN9/vZ
	rB61w0J84yVBoKzLTgwhqVJqFAjxPinLb+56mTbL4b31AgWSXz972frQ2KaDpe76IU5Djb5l1Sg
	YHudC7d5Obq7Qvv2LMRoZ4eVtUyK07Cg3SAbeonOttImuEGi+UCr21Bx4ZUNxkems1Aj40zcSMp
	cbNqK2W1GpZuwd8b3EPtGw2y3wU+JlvcN0MBN6MaEUTbjG2EvN1OWOZSdUpwOAiWo7SfkDURTZ3
	h89a/2UYkauU6ME34Govlsmgm/MlWJWGebtnyiZXfoIQQ0kczERW8uWWCDJMOPDGk8HV+aA4W7n
	tQSZu9hFQr6zl4m9M7MDVqeldao3qlAajcWdKFZkqZtcRmogM1qQKy1EWC6DylSmLCxIpBfHBl/
	oIo7NOOtGmGSknlZH1Q/vphTTKXR/0YvlJT2zgfPdGd4JneYwKkfUuNmjS8vHjFE7kq2q6eOc3H
	1kV/cMov4qIK81Tlvsd37TAT547x6w7ZSYTI8WdHQ==
X-Received: by 2002:a05:6820:4d05:b0:67d:fa1a:a660 with SMTP id 006d021491bc7-67dff5142ebmr685123eaf.41.1774385591560;
        Tue, 24 Mar 2026 13:53:11 -0700 (PDT)
Received: from Atwell-Laptop.. (108-212-132-20.lightspeed.irvnca.sbcglobal.net. [108.212.132.20])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67c252c91d0sm9125161eaf.5.2026.03.24.13.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 13:53:11 -0700 (PDT)
From: Wesley Atwell <atwellwea@gmail.com>
To: netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	David Ahern <dsahern@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Simon Baatz <gmbnomis@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wesley Atwell <atwellwea@gmail.com>
Subject: [PATCH net-next v3 2/3] tcp: keep scaled no-shrink window representable
Date: Tue, 24 Mar 2026 14:53:00 -0600
Message-ID: <20260324205301.1361608-3-atwellwea@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260324205301.1361608-1-atwellwea@gmail.com>
References: <20260324205301.1361608-1-atwellwea@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[google.com,kernel.org,gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-271299-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[atwellwea@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 76EE431C95D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In the scaled no-shrink path, __tcp_select_window() currently rounds the
raw free-space value up to the receive-window scale quantum.

When raw backed free_space sits just below the next quantum, that can
expose fresh sender-visible credit beyond the currently backed receive
space.

Fix this by keeping tp->rcv_wnd representable in scaled units: round
larger windows down to the scale quantum and preserve only the small
non-zero case that would otherwise scale away to zero.

This series intentionally leaves that smaller longstanding non-zero case
unchanged. The proven bug and the new reproducer are both in the
larger-window path where free_space is at least one scale quantum, so
changing 0 < free_space < granularity into zero would be a separate
behavior change.

That representability matters across ACK transitions too, not only on
the immediate raw-free_space-limited ACK. tcp_select_window() preserves
the currently offered window when shrinking is disallowed, so if an
earlier ACK stores a rounded-up value in tp->rcv_wnd, a later
raw-free_space-limited ACK can keep inheriting that extra unit.

Keeping tp->rcv_wnd representable throughout the scaled no-shrink path
prevents that carry-forward and makes later no-shrink decisions reason
from a right edge the peer could actually have seen on the wire.

This removes the larger-window quantization slack while preserving the
small non-zero case needed to avoid scaling away to zero.

Signed-off-by: Wesley Atwell <atwellwea@gmail.com>
---
v3:
- keep granularity in signed int space so the free_space comparison
  stays type-safe

v2:
- rename gran to granularity
- clarify why representable tp->rcv_wnd state is required across later
  no-shrink transitions
- clarify that this series still intentionally leaves the smaller
  longstanding non-zero case unchanged

 net/ipv4/tcp_output.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 35c3b0ab5a0cb714155d5720fe56888f71aecced..5fc0e0d22f10bf56ece1be536b75013768112acf 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3375,13 +3375,19 @@ u32 __tcp_select_window(struct sock *sk)
 	 * scaled window will not line up with the MSS boundary anyway.
 	 */
 	if (tp->rx_opt.rcv_wscale) {
-		window = free_space;
+		int granularity = 1 << tp->rx_opt.rcv_wscale;
 
-		/* Advertise enough space so that it won't get scaled away.
-		 * Import case: prevent zero window announcement if
-		 * 1<<rcv_wscale > mss.
+		/* Keep tp->rcv_wnd representable in scaled units so later
+		 * no-shrink decisions reason about the same right edge we
+		 * can advertise on the wire. Preserve only a small non-zero
+		 * offer that would otherwise get scaled away to zero.
 		 */
-		window = ALIGN(window, (1 << tp->rx_opt.rcv_wscale));
+		if (free_space >= granularity)
+			window = round_down(free_space, granularity);
+		else if (free_space > 0)
+			window = granularity;
+		else
+			window = 0;
 	} else {
 		window = tp->rcv_wnd;
 		/* Get the largest window that is a nice multiple of mss.
-- 
2.43.0

