Return-Path: <netdev+bounces-176152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2C9A691C7
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 15:57:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B15E7AEC1B
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 14:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA231C84C1;
	Wed, 19 Mar 2025 14:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FybiXmq4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7608F1C4A24;
	Wed, 19 Mar 2025 14:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742395755; cv=none; b=Fti/gKfu66lSYLl/T/9sAaY5ibFi70jkgMfb/ggm19kF/v3GuxCDxTHeUPGcexDKduSUmqDp0xaHoKh1lHfDAUUKVdLELoAW3HCK9hqqbrDi5JRFqLjWdXWcy/2VUruU0QNYn8c2PHQYUSwfokM7LXbewfi0o6SrJenVjpEi7JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742395755; c=relaxed/simple;
	bh=IgqdygoDFkNgkx3Pd8VQh6/rq2Y3/f/9Yb1pi8jeRks=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=JbZ5YadqFmTw/ws3njDJgwgBc01pRAR5eHC3klpM5fl4s6frc4F4UWiQAQ30SyIH/gHexsvv+wPWi1+ji89ltU8jxzo9vZ11O0qfYlmhKYKb/556SV0iEPWQ6Fb6NUDM2Oys4dRRORGo1xxo+U2cfOp603L9JtTkgsTtP0eDJo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FybiXmq4; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6e8fd49b85eso16972746d6.0;
        Wed, 19 Mar 2025 07:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742395752; x=1743000552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SQTPTxM0JT11SSMTW8cQivSj7lB8UZ8KUBStzQyLTrk=;
        b=FybiXmq4RO9e+/ka1N/Ar74nYb9uGf30FHZaP3tbLSlQGPTUR8QE1opnoZgnnU0RNN
         VBwLGd4Sb+0q4nIzxAPyXcVDbEp3zMB0YLXS8QmkyM65hnr+2ncWVRugWa7MxTjTaEc9
         OmRpp/nvyRppjoTX/D+iLZeOgs6IdWXm/wKguZ5F6XwSxnHk9V09Gf5/JbVN1owklIiH
         AGZDX9Y7rNvgSSw5HYdMSXCxSjAx+9lSV+uEc1Y5ZEXMIkiSnVt9updudjnfGTW68IiH
         xAvTCz4ofqbiNG/CCXdHxv/t/EQqEnW0Ka5k+ND2RnA/ditKyfsbbyKJLTXTvql3lExT
         C4aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742395752; x=1743000552;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SQTPTxM0JT11SSMTW8cQivSj7lB8UZ8KUBStzQyLTrk=;
        b=Dw/uDrbEau66stRz2Q2qViBNAThv7jum0G3U1C4eAmMZue5SLhSe6KlVUiO/M+DqCK
         jJ6uh1WY3aprTeTYw8io+jlDkkhcgW6IAqcmJKg7dppNZd+iblbgItIJn0K4jVnMzsvv
         7Tct2hRtOgDHUlKNJqkxpyVwBYxska7RSuDI23rsvrbj7V15SM9q89v1hekJmfCf7c7q
         9Ncrnx3ESPQTTSUyvn0+fo1iWyTj/Eh1gB1IiZN1KEFnf/hls8ZUOIILc9whQNJu7aBM
         zLUz+Rakpj7UL7qfgAwdUziuWnB/Gbjdh+R/plVVA0aTKFNeJSmPqMQMojiwITi1zafc
         XChg==
X-Forwarded-Encrypted: i=1; AJvYcCUh4/zTuSnv9aq+zzDIChFhK1dQwSQK6AvR2PUm8sIF3lvVvNaMtwaxXEenPZcXTwz9stGV+AZ9KdJB1zOfUFU=@vger.kernel.org, AJvYcCV/frI6a8qNsmsa/6qEggAoBqBOMpDByhu74En6yJ0QLVqS/XMLi7biHPhtFbMr4sXyFXCKHW40@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy1hKAF1zePyBeRtDHcSrBaw7oIRn4i0GP3NreRgeAjfUGQFRb
	lM9OlLquPuIddaR5o74jhOyxv2tUveGm1LknmBB81M2NJSuxu7+Jw3Bn2w==
X-Gm-Gg: ASbGncvOpproZxV8UZZ0VX6QzePd7qcpl1mhGi49FXXswWpIW6TMpfBRsXO+28FU5Yu
	5rw3g62IAhDBnDAW9xy+Jh6PEOKN8gXQFgbLCe+q1JyxpcwklVqxLj1udpOLarXqTujQyaHb/oL
	akwmiWDLPTd/Zb6L6EiwS1JZu4/P0+WgAFSXXOp+xS+iFyqh0wEIEQ06Bz6oR9QyG0vS9wE5RVb
	DVXr0X/ImC9v1W3WREQ4Rm66D+kadLbcs+K2iDGqu2cUwX1U0XfKzItDKqam2PQIVO6qPxmYQzJ
	LE1PEcSPk5MiNZVZeCN5CrYYBSE+rcC+reuMhMOgK+C4Hihp9WR8wlITyz1X2B7dDAJMi7Ujx7O
	2W+Y+tFM1hadAHincEfd9Kw==
X-Google-Smtp-Source: AGHT+IECNHCRRJCTPE5ymJeNjONA3wR4/ZXwaHa5hu3l6CGS1uSHgFotC5xcZKcHUyoF2AHdSp7/HA==
X-Received: by 2002:a05:6214:27e4:b0:6e8:fb7e:d33a with SMTP id 6a1803df08f44-6eb293a9a0dmr40013316d6.22.1742395752111;
        Wed, 19 Mar 2025 07:49:12 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eade330cf4sm81407196d6.77.2025.03.19.07.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 07:49:11 -0700 (PDT)
Date: Wed, 19 Mar 2025 10:49:11 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Pauli Virtanen <pav@iki.fi>, 
 linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 netdev@vger.kernel.org, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 willemdebruijn.kernel@gmail.com
Message-ID: <67dad9672e000_5948294b6@willemb.c.googlers.com.notmuch>
In-Reply-To: <af69c75a4d38e42bb11b344defc96adc5f703357.1742324341.git.pav@iki.fi>
References: <cover.1742324341.git.pav@iki.fi>
 <af69c75a4d38e42bb11b344defc96adc5f703357.1742324341.git.pav@iki.fi>
Subject: Re: [PATCH v5 3/5] Bluetooth: ISO: add TX timestamping
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Pauli Virtanen wrote:
> Add BT_SCM_ERROR socket CMSG type.
> 
> Support TX timestamping in ISO sockets.
> 
> Support MSG_ERRQUEUE in ISO recvmsg.
> 
> If a packet from sendmsg() is fragmented, only the first ACL fragment is
> timestamped.
> 
> Signed-off-by: Pauli Virtanen <pav@iki.fi>
> ---
> 
> Notes:
>     v5:
>     - use sockcm_init -> hci_sockcm_init
> 
>  include/net/bluetooth/bluetooth.h |  1 +
>  net/bluetooth/iso.c               | 24 ++++++++++++++++++++----
>  2 files changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
> index 435250c72d56..bbefde319f95 100644
> --- a/include/net/bluetooth/bluetooth.h
> +++ b/include/net/bluetooth/bluetooth.h
> @@ -156,6 +156,7 @@ struct bt_voice {
>  #define BT_PKT_STATUS           16
>  
>  #define BT_SCM_PKT_STATUS	0x03
> +#define BT_SCM_ERROR		0x04
>  
>  #define BT_ISO_QOS		17
>  
> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> index 0cb52a3308ba..3501a991f1c6 100644
> --- a/net/bluetooth/iso.c
> +++ b/net/bluetooth/iso.c
> @@ -518,7 +518,8 @@ static struct bt_iso_qos *iso_sock_get_qos(struct sock *sk)
>  	return &iso_pi(sk)->qos;
>  }
>  
> -static int iso_send_frame(struct sock *sk, struct sk_buff *skb)
> +static int iso_send_frame(struct sock *sk, struct sk_buff *skb,
> +			  const struct sockcm_cookie *sockc)
>  {
>  	struct iso_conn *conn = iso_pi(sk)->conn;
>  	struct bt_iso_qos *qos = iso_sock_get_qos(sk);
> @@ -538,10 +539,12 @@ static int iso_send_frame(struct sock *sk, struct sk_buff *skb)
>  	hdr->slen = cpu_to_le16(hci_iso_data_len_pack(len,
>  						      HCI_ISO_STATUS_VALID));
>  
> -	if (sk->sk_state == BT_CONNECTED)
> +	if (sk->sk_state == BT_CONNECTED) {
> +		hci_setup_tx_timestamp(skb, 1, sockc);
>  		hci_send_iso(conn->hcon, skb);
> -	else
> +	} else {
>  		len = -ENOTCONN;
> +	}
>  
>  	return len;
>  }
> @@ -1348,6 +1351,7 @@ static int iso_sock_sendmsg(struct socket *sock, struct msghdr *msg,
>  {
>  	struct sock *sk = sock->sk;
>  	struct sk_buff *skb, **frag;
> +	struct sockcm_cookie sockc;
>  	size_t mtu;
>  	int err;
>  
> @@ -1360,6 +1364,14 @@ static int iso_sock_sendmsg(struct socket *sock, struct msghdr *msg,
>  	if (msg->msg_flags & MSG_OOB)
>  		return -EOPNOTSUPP;
>  
> +	hci_sockcm_init(&sockc, sk);
> +
> +	if (msg->msg_controllen) {
> +		err = sock_cmsg_send(sk, msg, &sockc);
> +		if (err)
> +			return err;
> +	}
> +

Minor: do you want to return an error if the process set unexpected
sockc fields?

If allowing to set them now, but ignoring them, it will be harder to
support them later. As then it will result in a kernel behavioral
change for the same sendmsg() call.

Though I suppose that is already the case if all cmsg are ignored
currently. So fine to keep if you don't care.

