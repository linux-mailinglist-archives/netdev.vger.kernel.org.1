Return-Path: <netdev+bounces-81972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F2088BF9A
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 11:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB7431C3E42C
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 10:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E3BA21;
	Tue, 26 Mar 2024 10:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="rOX7nVgl"
X-Original-To: netdev@vger.kernel.org
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E464E647
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 10:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711449302; cv=none; b=OC2TvZ7UaQRovRtwihT1wTYENNzqQN9HBBOOW6t8Iia3Bhy/e1phnhxSveUyu+SE5GFVbCNZheXNG0mLtBG3dO1+yXfqSRtViYV9pGrirtD3BdPqvhbJBfR0N6lzK8QIwyy9od6rrnIYk7YHcHNp0fhIuXv7A8pxslvDJDc6CrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711449302; c=relaxed/simple;
	bh=zx7rp84rpMHxYYtRzuocVcx7wewSU3pLSsGh+GLqNtI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aAqT6Sdw2LuVkwOIYO4rhNjy8BWFrhWLhOQg5vEhkWFTEl1AcptPWwqWpI7r+s3p75xXUsSKiKfmJEzuX5xVzuRoB5KRF7WG1sge9DlFHpJ8TXrf/jk54/QvxhCdf/NZdvprpZHBXnKPwMgox3oTUcDeZt8v8EsgUdBwqfJTVMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=rOX7nVgl; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Type:MIME-Version:Message-ID:Date:References:
	In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=mzLUNXVhYloQmBZakIKR03yiCNJVp1g7o7xh0Q0gTZI=; b=rOX7nVgluDmoGyBif55Fom2irV
	I/tRbOiVvsashbOEjKavT/1srCOkO1KXqH6ZtZkXHb4EwwAAXVhVXpoGe7HL+We/QarqSppS+7fea
	5Ei3kiuSwhKl+kfsJhrSMOzH0Pv8xqSOm/cz4upu3gQ5wjidTrfNcSH7tWpfRpSJztGN4/yeHYUmO
	xCXhwo+r53YoKHizJHM71RFLNhnKGAKeQeM8jLxZoOcdPDDdvaj4l9+KkRWtqT4BiaNvoSg0ddg2S
	z0dBJ1+Bg2gW87UAlklTgvtkxpLQWIqd8TzeXnW46n/X/3/Z3qG6QZKISCh8Sk+uRCncyZv/jZB7k
	prGtterw==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1rp48r-000Pye-9r; Tue, 26 Mar 2024 11:34:53 +0100
Received: from [185.17.218.86] (helo=localhost)
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1rp48q-000PGr-2g;
	Tue, 26 Mar 2024 11:34:52 +0100
From: Esben Haabendal <esben@geanix.com>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org,  Jakub Kicinski <kuba@kernel.org>,  Sergey
 Ryazanov <ryazanov.s.a@gmail.com>,  Paolo Abeni <pabeni@redhat.com>,  Eric
 Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next v2 06/22] ovpn: introduce the ovpn_peer object
In-Reply-To: <20240304150914.11444-7-antonio@openvpn.net> (Antonio Quartulli's
	message of "Mon, 4 Mar 2024 16:08:57 +0100")
References: <20240304150914.11444-1-antonio@openvpn.net>
	<20240304150914.11444-7-antonio@openvpn.net>
Date: Tue, 26 Mar 2024 11:34:52 +0100
Message-ID: <871q7xe0xf.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27226/Tue Mar 26 09:37:28 2024)

Antonio Quartulli <antonio@openvpn.net> writes:

> +static inline bool ovpn_bind_skb_src_match(const struct ovpn_bind *bind, struct sk_buff *skb)
> +{
> +	const unsigned short family = skb_protocol_to_family(skb);
> +	const struct ovpn_sockaddr *sa = &bind->sa;

You should move this dereferencing of bind to after the following check
to avoid segmentation fault.

> +	if (unlikely(!bind))
> +		return false;

> diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
> new file mode 100644
> index 000000000000..4319271927a4
> --- /dev/null
> +++ b/drivers/net/ovpn/peer.c
> +
> +/* Use with kref_put calls, when releasing refcount
> + * on ovpn_peer objects.  This method should only
> + * be called from process context with config_mutex held.
> + */
> +void ovpn_peer_release_kref(struct kref *kref)
> +{
> +	struct ovpn_peer *peer = container_of(kref, struct ovpn_peer, refcount);
> +
> +	INIT_WORK(&peer->delete_work, ovpn_peer_delete_work);

Is this safe, or could we end up re-initializing delete_work while it is
queued or running?

> +	queue_work(peer->ovpn->events_wq, &peer->delete_work);

/Esben

