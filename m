Return-Path: <netdev+bounces-75626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DB486AB75
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 10:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEBF41F245AF
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 09:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D782E403;
	Wed, 28 Feb 2024 09:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="vAFDuAOM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4E9364A4
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 09:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709113085; cv=none; b=FAogPkVhp5q6omnVcahSdEycIMStR9oP852730wz1590zyyK4Ttpq301H85Yi13rZBwRGHyI4dzu/qMdVLqX4MagoUNyMJGOauzl1bQH83bDnHydXsrsPvlAMBYFxHBRx+wBqcYNL7uueavNeMjZ0V+lZuap8Fb6+uMWka7lh/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709113085; c=relaxed/simple;
	bh=QgIy+AhjKbi6kBVZg0TLRYJ9MziReGlesw4xPyyJCBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SQRwWZ9Re7TS+hP1L1Q/zdu/E9AMo/UFpzBgsBCJWEfB+0mDjhnfC1NOLOO+mNvTuABUFJzQXnqO8XBrzbn2F6lfDYmxpUUZJHrPN712sIo1SoSGXxNECJObqEwzEJwQFUvgB1eHVd0BiggmhGeB+RB8duCfcU+ZO3IOIMeV21E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=vAFDuAOM; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-412ae087378so11628395e9.3
        for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 01:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709113082; x=1709717882; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W1hMWRVBnl/gEAw/llhlBpcXQ1X9m0oJHMIf8z3WgWc=;
        b=vAFDuAOMhv789HpMwyn2TL6aFd98083xX86F+D+U7F6jmdKepK8XPPWyiNnhJKw/6d
         RcCqLUyazdCpi5ut9n4SOFRCmce/pxbmK58YuvWEORrLQBluQ0s9BeCl+3lnpAz/jcsm
         EFr3oU9XXQdyRu61sWfAnV8G54x/Ynl53h7DbBAzoLF8iB7xbB58fmleG7MTY4movSq7
         nhhvRA0xrkdruAtVhH57Rom/vkiDJTZY8z9Hb+5ur50hNE4U1rHoXFe0TLCmAE0eMD4Q
         R+JjJgKHei6GX4c/0kAf0nQy5/i2rCnW8TZLnbPIkVM/leTmvU4/crq9gGL2XQoW3uev
         EReA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709113082; x=1709717882;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W1hMWRVBnl/gEAw/llhlBpcXQ1X9m0oJHMIf8z3WgWc=;
        b=uhv57mFIuMsCMkVBAAp4DQpQuXhdXBETQaYTB/uKZyxYzXKSmHyZ6dVyEB7llkwdNN
         86wq/4uhDFjH5dOy7S8H+TJN2kGl1+m+3pyn2pc9hmQCjib1xq193Q0bu6U3lYRxB1me
         lTK29xBfpqQRY1DTCok019ND0aYNVEPInjqaRdKNSk39HFgPgoN4HLa2DQx3UwSQNIOt
         UFStl6pq5Ab94I64DR0Hq5OB2Zjhqe8zbItwmOKO3nOJeYam2wE3KoZk6e5DvOtOtrUJ
         uI3W3JwaKwxb423vlJ4h7pbSaawVbe4b2lu77LsGyp5wzjVQsWXVX9R8xkM6b6nia+t/
         tJbw==
X-Forwarded-Encrypted: i=1; AJvYcCWn/NhX7qDXqyaZkyharEMbPkHC6pWogCX8BxtjJDkGCs6evs+tINUhQIyWhhkNYkVrDOqJMqfBDCrAIxaa6UFWWxKoGatq
X-Gm-Message-State: AOJu0Yw0/eqDswgfgchTl0N1OoM94+IzROYbrdhsS1u28dqqHy8/B3Du
	G0mlxwVJRrDQk2v1lso5hSJmWslhjj8SqxwPNDvKkMPGTmxl1EaBdX7goUspsRw=
X-Google-Smtp-Source: AGHT+IEOxWRC6Ca+8XbgbqTWQoyUFENl9LPww7J0YEXEZZ0erws498PgvVW8RhPGdX7h1yqhcEDVMA==
X-Received: by 2002:a05:600c:3b9d:b0:412:b623:bbcc with SMTP id n29-20020a05600c3b9d00b00412b623bbccmr497210wms.10.1709113082050;
        Wed, 28 Feb 2024 01:38:02 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id cs2-20020a056000088200b0033e002b32a3sm1148845wrb.30.2024.02.28.01.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 01:38:00 -0800 (PST)
Date: Wed, 28 Feb 2024 10:37:56 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org,
	Oleksij Rempel <o.rempel@pengutronix.de>, richardcochran@gmail.com,
	nathan.sullivan@ni.com, Jacob Keller <jacob.e.keller@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: Re: [PATCH net] igb: extend PTP timestamp adjustments to i211
Message-ID: <Zd7-9BJM_6B44nTI@nanopsycho>
References: <20240227184942.362710-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227184942.362710-1-anthony.l.nguyen@intel.com>

Tue, Feb 27, 2024 at 07:49:41PM CET, anthony.l.nguyen@intel.com wrote:
>From: Oleksij Rempel <o.rempel@pengutronix.de>
>
>The i211 requires the same PTP timestamp adjustments as the i210,
>according to its datasheet. To ensure consistent timestamping across
>different platforms, this change extends the existing adjustments to
>include the i211.
>
>The adjustment result are tested and comparable for i210 and i211 based
>systems.
>
>Fixes: 3f544d2a4d5c ("igb: adjust PTP timestamps for Tx/Rx latency")

IIUC, you are just extending the timestamp adjusting to another HW, not
actually fixing any error, don't you? In that case, I don't see why not
to rather target net-next and avoid "Fixes" tag. Or do I misunderstand
this?


>Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
>Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
>Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
>Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
>---
> drivers/net/ethernet/intel/igb/igb_ptp.c | 5 +++--
> 1 file changed, 3 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/net/ethernet/intel/igb/igb_ptp.c b/drivers/net/ethernet/intel/igb/igb_ptp.c
>index 319c544b9f04..f94570556120 100644
>--- a/drivers/net/ethernet/intel/igb/igb_ptp.c
>+++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
>@@ -957,7 +957,7 @@ static void igb_ptp_tx_hwtstamp(struct igb_adapter *adapter)
> 
> 	igb_ptp_systim_to_hwtstamp(adapter, &shhwtstamps, regval);
> 	/* adjust timestamp for the TX latency based on link speed */
>-	if (adapter->hw.mac.type == e1000_i210) {
>+	if (hw->mac.type == e1000_i210 || hw->mac.type == e1000_i211) {
> 		switch (adapter->link_speed) {
> 		case SPEED_10:
> 			adjust = IGB_I210_TX_LATENCY_10;
>@@ -1003,6 +1003,7 @@ int igb_ptp_rx_pktstamp(struct igb_q_vector *q_vector, void *va,
> 			ktime_t *timestamp)
> {
> 	struct igb_adapter *adapter = q_vector->adapter;
>+	struct e1000_hw *hw = &adapter->hw;
> 	struct skb_shared_hwtstamps ts;
> 	__le64 *regval = (__le64 *)va;
> 	int adjust = 0;
>@@ -1022,7 +1023,7 @@ int igb_ptp_rx_pktstamp(struct igb_q_vector *q_vector, void *va,
> 	igb_ptp_systim_to_hwtstamp(adapter, &ts, le64_to_cpu(regval[1]));
> 
> 	/* adjust timestamp for the RX latency based on link speed */
>-	if (adapter->hw.mac.type == e1000_i210) {
>+	if (hw->mac.type == e1000_i210 || hw->mac.type == e1000_i211) {
> 		switch (adapter->link_speed) {
> 		case SPEED_10:
> 			adjust = IGB_I210_RX_LATENCY_10;
>-- 
>2.41.0
>
>

