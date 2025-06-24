Return-Path: <netdev+bounces-200504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6E1AE5BDC
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 07:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09D5E4440A7
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 05:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26C4223DD0;
	Tue, 24 Jun 2025 05:29:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD404C74;
	Tue, 24 Jun 2025 05:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750742955; cv=none; b=M9dfrh19Ajs3kRskAH37eCSJFf0YVizLtxpCml0glVP9xyFy0FV4042+bxPHstKPEoZ5mMNtLo4StQbHn0nTfY0H4KWTVcRvzY6RESXQmVIRtVj7Y2hzXd1jBsTGqGoS70bZ8NH+WMeHNwYrx9UKdhj9BtNB1ZDHxMN1R8faXLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750742955; c=relaxed/simple;
	bh=UKRjY5dqheg932jcCpNQUs+aaZ31mj9735W1eRDtzoo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZaIU8uqSZD85xm3guDEWdyMGosZBFJRbgWbjpOD/fhRGHRbS+IIjStl1mXIu98DrN9SrR4WliJdjM4PLjPyX0vAAGK9iP9kYrqN00wFKmvWTPZCXhBDZOy07sh4HBL1I6USQhgLJ1GM2npV7qzuQnv7to4zmRpfgjpSmqTIX7d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.192] (ip5f5af60b.dynamic.kabel-deutschland.de [95.90.246.11])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 2B4DE61E647A8;
	Tue, 24 Jun 2025 07:28:33 +0200 (CEST)
Message-ID: <4db45281-9943-4ed7-80c6-04b39c3e9a5e@molgen.mpg.de>
Date: Tue, 24 Jun 2025 07:28:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: hci_event: Add support for handling LE BIG
 Sync Lost event
To: Li Yang <yang.li@amlogic.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250624-handle_big_sync_lost_event-v1-1-c32ce37dd6a5@amlogic.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250624-handle_big_sync_lost_event-v1-1-c32ce37dd6a5@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Li,


Thank you for your patch.


Am 24.06.25 um 07:20 schrieb Yang Li via B4 Relay:
> From: Yang Li <yang.li@amlogic.com>
> 
> When the BIS source stops, the controller sends an LE BIG Sync Lost
> event (subevent 0x1E). Currently, this event is not handled, causing
> the BIS stream to remain active in BlueZ and preventing recovery.

How can this situation be emulated to test your patch?

> Signed-off-by: Yang Li <yang.li@amlogic.com>
> ---
>   include/net/bluetooth/hci.h |  6 ++++++
>   net/bluetooth/hci_event.c   | 23 +++++++++++++++++++++++
>   2 files changed, 29 insertions(+)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 82cbd54443ac..48389a64accb 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -2849,6 +2849,12 @@ struct hci_evt_le_big_sync_estabilished {
>   	__le16  bis[];
>   } __packed;
>   
> +#define HCI_EVT_LE_BIG_SYNC_LOST 0x1e
> +struct hci_evt_le_big_sync_lost {
> +	__u8    handle;
> +	__u8    reason;
> +} __packed;
> +
>   #define HCI_EVT_LE_BIG_INFO_ADV_REPORT	0x22
>   struct hci_evt_le_big_info_adv_report {
>   	__le16  sync_handle;
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 66052d6aaa1d..730deaf1851f 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -7026,6 +7026,24 @@ static void hci_le_big_sync_established_evt(struct hci_dev *hdev, void *data,
>   	hci_dev_unlock(hdev);
>   }
>   
> +static void hci_le_big_sync_lost_evt(struct hci_dev *hdev, void *data,
> +					    struct sk_buff *skb)
> +{
> +	struct hci_evt_le_big_sync_lost *ev = data;
> +	struct hci_conn *conn;
> +
> +	bt_dev_dbg(hdev, "BIG Sync Lost: big_handle 0x%2.2x", ev->handle);
> +
> +	hci_dev_lock(hdev);
> +
> +	list_for_each_entry(conn, &hdev->conn_hash.list, list) {
> +		if (test_bit(HCI_CONN_BIG_SYNC, &conn->flags))
> +			hci_disconn_cfm(conn, HCI_ERROR_REMOTE_USER_TERM);
> +	}
> +
> +	hci_dev_unlock(hdev);
> +}
> +
>   static void hci_le_big_info_adv_report_evt(struct hci_dev *hdev, void *data,
>   					   struct sk_buff *skb)
>   {
> @@ -7149,6 +7167,11 @@ static const struct hci_le_ev {
>   		     hci_le_big_sync_established_evt,
>   		     sizeof(struct hci_evt_le_big_sync_estabilished),
>   		     HCI_MAX_EVENT_SIZE),
> +	/* [0x1e = HCI_EVT_LE_BIG_SYNC_LOST] */
> +	HCI_LE_EV_VL(HCI_EVT_LE_BIG_SYNC_LOST,
> +		     hci_le_big_sync_lost_evt,
> +		     sizeof(struct hci_evt_le_big_sync_lost),
> +		     HCI_MAX_EVENT_SIZE),
>   	/* [0x22 = HCI_EVT_LE_BIG_INFO_ADV_REPORT] */
>   	HCI_LE_EV_VL(HCI_EVT_LE_BIG_INFO_ADV_REPORT,
>   		     hci_le_big_info_adv_report_evt,

Kind regards,

Paul

