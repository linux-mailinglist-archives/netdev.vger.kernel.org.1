Return-Path: <netdev+bounces-259941-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKanFxYTnGk4/gMAu9opvQ
	(envelope-from <netdev+bounces-259941-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 09:43:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6CCD173385
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 09:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 371633010B9E
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 08:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B0334D4DC;
	Mon, 23 Feb 2026 08:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RNMTDRYA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097E134B40C
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 08:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771836179; cv=pass; b=WP+SCk1pMDavv9flpmVQzrsD4Q5GUVDTN5s114Qm6q5waQZlstlB47wbYCPoG8kgOlFeG4RMoFHbYgbRqsYjwsTH24QLVJdaeCz2yMzbDRbVCmNKOrTCCiztifhaqVoLMW+rTALeKT4mEp8IzmzdpQGYGwjxR/Go2ACSF86diHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771836179; c=relaxed/simple;
	bh=DTu+tH08W5HUEEPKpct02840YPC0Y/czDYA0T4vjVek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AttboDagNLNVTPcejEaIWaGCXTErz4XgFPJL9IvfqD814uufvt7DYe15twz/AvzdMrzuQJ1AqAJSH3qyd3NxCdK2W2Lm2Kmw/pnEUWoA7ki+nXjxu+FpYWpue65ovtU/LndlovBkY56/xzp5daxl/Quv3oDQiibtpkw/ysSqM3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RNMTDRYA; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-502a789834fso36192411cf.2
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 00:42:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771836177; cv=none;
        d=google.com; s=arc-20240605;
        b=epjezyjzFNJUTMccka29yvnXIgn076TS4vn1HrXGPZFqiC1TKQMfW3W4lW5r3k1Qqm
         YhdQjR+bAdHavBiuvGaTNljG9oGkblfueVAltDqpWYNhNW6Nk8rieegqnpwA03+lYbbN
         tQr77e3hf2FUhSgkqU0FcwDjWNwIQb/1I61U1V3itbW3AYB7l8d3TJLlBOd5AEykaV+d
         LIQNeCm2H24YyIxP3Px9g7vpjWmO4VN3BhEBclWtvxlMUT01F7VJraduRgzzgBwGDpc3
         WrZRG4A1cZY4IJadMRMU8MHKGp7HnBJwg1PZUpOxZdQ+8mG4prBIOiITUeeGc3h4Jwgp
         dbiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DTu+tH08W5HUEEPKpct02840YPC0Y/czDYA0T4vjVek=;
        fh=3VlMT2KXuy/snbwWEaoxdWlgsVDl9691aT20R7YawmM=;
        b=OPgWm4AYPSwT9nycUwy9M3JYdaCFvonM3DFY8O5hFVU/8kgtqIiN2E+g+caFkF0tlo
         Ny5oiBHauIEHZcmlfYY/Gs7syX89jLBqJG++EdF3I3QQZxfN1ASGZdlABY5VBU8JBxxg
         siOPHLLYY16PKkqhSBemZf+jmqUbv4k6r2j1d3grosJ+WaD1F0M0PQpVc++Dzjh6XCIo
         EJxsRQzmdUKhC03qNLxZCNNMAF/Bwn/9U1l1gZWZwMd6E4QH1aUhvwotAH29X+15WLJH
         HeKR0vmm+5zavzDfOHzmZtzfvAZlTdZhEyAZyDxP1yyXvFdNWy8zZx1BUccJl1l+CRbD
         Ch6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771836177; x=1772440977; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DTu+tH08W5HUEEPKpct02840YPC0Y/czDYA0T4vjVek=;
        b=RNMTDRYAmbvPyYugKt/qA1cQF6JD7s0ZvPqxRWPYhYnIp2NozYgu7MgYJ9OxOHr33j
         bv4PR67ck4AN9U7uiHKKyraHGfLy/7O6UlTGjyqfprScfG/FP8MzKZmoePabmEsnIAKz
         qQeEbOMSCfIOMct+dnSx7/cD1dTuGSNpiI8ST7+PlJJZHf0If7kIF9HqIiiVOSMEV90c
         6R9d9UqeuYkIVqmSrifkm0lNt44hdw3iK49ilkqGHeEdRiuJDD9Z8h87fjl1YtiAv7Jp
         jpToYldfFpvwNB6JQhtGkF2UHTZwlvBFKc6k1+W7BFPYuw8+xvbTx2uzRusGNqncWry8
         zu3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771836177; x=1772440977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DTu+tH08W5HUEEPKpct02840YPC0Y/czDYA0T4vjVek=;
        b=Ua0WOiHpKABwvjVkVGIKg4xKIrjsJqEhgq0/FCTM39oVpC51ybU5MdQop68MGNxtbF
         EMUtI8D0m5cQzLunl93ofc9/CDtGHU2nqKXgICr9XhTwiEDmppxaHxBxZBf8PqeoaAL1
         wpvKXOpcCp8NeevvYEEzr7skVUwgYGMiUQNBi/PGVgE1aVdQs0xFYD/pBJax/1oI9Izx
         6xdagDm9yiQnjvFGO/0wC5mkKe5whK+ektqLDrivm9Zs9cV9Yhm5h+QJPhU/XRU/LoRB
         uAS9r+p+6lZVPANHuRSR2nAUO5sozL3icH5zR0wX6/7TISoHsns+h/bwqjDg1DIA9H/S
         UXXw==
X-Gm-Message-State: AOJu0YyihkasPh7P3INVosTb9itpaYGDYwATr5z0PIg/EMruX80Xqmox
	peRZQapFMgiHAWAMqNBCHngppeR6CmCd5uluHCWSUiy+Z8JLPlScDdWaTsQzfdF0W7yRtERiOdd
	lFrnPKbE5Uc894iiX7nD1AXpOJgiYDg2pa1pRAdYt
X-Gm-Gg: AZuq6aLxtJTpHJqg64ow+EuwAyUBYi42dBWib5YD5t8d2Vg6PAgqhP7kxbSSctdAXbb
	9m4AC2AZosz6bIPiFtVfowg0DvZypYwJlBRFsJVO3YBncA9ia5QphwmkMdSWS9PzNz3d5Evbce5
	7sOok8OSIdXSo23zVrUc9zKQcVQVzpUqFdqBc/wzGWSmC6OiQmP3OX9x1QvHw6PJiJEgIxGUlfY
	Yu63UzWOotCYzHGnmI/+skTHBsgpLfByfu1TSQNQieJyJxZ98yKXwpvjw7YYck0k8DYBJjGg+7c
	9IC/suQ=
X-Received: by 2002:a05:622a:8b:b0:4f3:5816:bd8d with SMTP id
 d75a77b69052e-5070bcf26c9mr117996101cf.62.1771836176630; Mon, 23 Feb 2026
 00:42:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220183858.N4ERjFW6@linutronix.de>
In-Reply-To: <20260220183858.N4ERjFW6@linutronix.de>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 23 Feb 2026 09:42:45 +0100
X-Gm-Features: AaiRm50IaHPe5inWp2qilcbSuZ_mp7Pb___hm_S4gtahGU5djQbzDJIiK0oqOlk
Message-ID: <CANn89iKSTXxber390V+O6dnZ4PGoZnRgW8SuU2eRHwWb7xnLyw@mail.gmail.com>
Subject: Re: [PATCH net v2] net: Drop the lock in skb_may_tx_timestamp()
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Kurt Kanzenbach <kurt@linutronix.de>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davemloft.net,kernel.org,linutronix.de,redhat.com,google.com];
	TAGGED_FROM(0.00)[bounces-259941-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,linutronix.de:email]
X-Rspamd-Queue-Id: A6CCD173385
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 7:39=E2=80=AFPM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> skb_may_tx_timestamp() may acquire sock::sk_callback_lock. The lock must
> not be taken in IRQ context, only softirq is okay. A few drivers receive
> the timestamp via a dedicated interrupt and complete the TX timestamp
> from that handler. This will lead to a deadlock if the lock is already
> write-locked on the same CPU.
>
> Taking the lock can be avoided. The socket (pointed by the skb) will
> remain valid until the skb is released. The ->sk_socket and ->file
> member will be set to NULL once the user closes the socket which may
> happen before the timestamp arrives.
> If we happen to observe the pointer while the socket is closing but
> before the pointer is set to NULL then we may use it because both
> pointer (and the file's cred member) are RCU freed.
>
> Drop the lock. Use READ_ONCE() to obtain the individual pointer. Add a
> matching WRITE_ONCE() where the pointer are cleared.
>
> Link: https://lore.kernel.org/all/20260205145104.iWinkXHv@linutronix.de
> Fixes: b245be1f4db1a ("net-timestamp: no-payload only sysctl")
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

