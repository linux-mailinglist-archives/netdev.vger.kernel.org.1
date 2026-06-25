Return-Path: <netdev+bounces-301963-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qdxQOqkvPWqYyggAu9opvQ
	(envelope-from <netdev+bounces-301963-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 15:39:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CDC6C6317
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 15:39:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=FddRbWzi;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301963-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-301963-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 601923041A62
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 13:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E080633ADB1;
	Thu, 25 Jun 2026 13:39:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B593328FC
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 13:39:27 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782394768; cv=pass; b=uRW59GObnhxiv3NNzavt8BrrfTN+6UoXOtASMS7vV09gSrBW9RlL/ydQGsDcw/I5SO0NtnGidrX14InkZxQu9hYMJyXAmxeBItONVre2SRoqvYq2O9jmQFPss4DL2LvwM8gfGWnGjPlUunsIvzNyx24za+lcOPd+phtxqNatHAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782394768; c=relaxed/simple;
	bh=OoFzKZW407yRUv5K0dGZKSk0BzM1rVvgeohYpJyht7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uPnG0bwl0Cw5Gol3wjFm5y4XqUhBLdaMVkreyKDubP1IVf/jUTbeHE0r5Cbp4HGHgETUuDS1ABjrhI5ajiwScd1TD2bABS4sWyeLXOf38izoRIJfYZnczLPIo/3b6ltdX43r/Eqy0tKtMBm1ie7DmR1mZp3b+vau7j6fbIMvohk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FddRbWzi; arc=pass smtp.client-ip=209.85.208.178
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-39ad188f6d8so5124021fa.3
        for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 06:39:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782394766; cv=none;
        d=google.com; s=arc-20260327;
        b=IesVj++wy26MQ+tY4X44+5z1w3Naxa14l0FpSbagu2a884MEaHKqkBQsyv4PPK2FoW
         C0bJMPoLfUnEt1rSzCiiv65l59vTn98u62NZ46H4yuMjitCwcnO/x7G0V8RTfycEEcX+
         vbrgeqp2we8pzcyIDRc9lcMCA4LP8KHYRYyuGSfdTWZa4ANfj055jXXlhcS1oTBhU8rd
         Trt1O5ZNDBmOtaA+po3i+mLX1jrim6sxWzDSDs7FIzf1xWB8cXRQXN+ER/0l0dIHZxHO
         kuJL8h38vjJVa2PQpTSxPX/fCC8dh+LsRiN0M6OD9hipJPDk4PnJbPuKVnBauLSslIn2
         499g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OoFzKZW407yRUv5K0dGZKSk0BzM1rVvgeohYpJyht7s=;
        fh=q1r88RbeZU5IhIu7xSLyyrEf0/MOLQlGDoKzK61hiIY=;
        b=qRxD/n37uRYiGrKO/Dua9bnRwpeqeIgmFnqw0O3TFoH+0ZTBKdJb94fN7z34et5K9/
         whZtXw7cYgBaMoJ4A0yjEpXDprB/hJ7IgHN6bux691esnKEy64Rc3wJhPGe2o43AvdAQ
         lW8hY2cU8H87wA+novvzZZhO/D3nfAbDsbGDSU7U3ZqI0R/K3ydMl3+wvNs91tFSRNHg
         YUXX0WkS2qmphVIwGWYH/2mHUns/4sEZascXXNQSfHKcPGw5O0jzYk1C8V5X0uapI7Wn
         VMjYXxHtdeO3JousSxTOuWeKFL/gIqzuYseUfrqj9MWMO5OM1oCgVApjKV5H8FmVzW++
         NZVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782394766; x=1782999566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OoFzKZW407yRUv5K0dGZKSk0BzM1rVvgeohYpJyht7s=;
        b=FddRbWziEAG1zi7AR9eeHcojKvXKJ2vMFeloIRmqCrfmcedh29jerCXj5jMW7KWv+4
         qn+bdXlrYuLyX413az9wASfs3768Pqpn1XTSP7pT02s7BGDc0fhuyZoZH03rRewWG1+M
         sBb7TyBO0VurkvwAuF+ozARFzs0bz4JBGuG7HXVEWk2RGbGiTrf6cu5W4pXgyscXhP1A
         HMZgmcJmSPV/6XJ88s2gHIHgLjcue0qjhHUms5X11636903RR2TIU4U8ZRsFw7KV2BZh
         DEt6w/88ZzjvPCVj5+1N5BmwxGgPocJERuGzKpwcxDARrIuGcAwpW7ll4MmfG9xCgumG
         VmHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782394766; x=1782999566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OoFzKZW407yRUv5K0dGZKSk0BzM1rVvgeohYpJyht7s=;
        b=gGp8zL+dDjtE0lbMvWKOMWNtJOtRRmOyZivVHtUIcAy/Lc0QgneMoU4kQHQY/yTw4K
         tejzz2ngiNdZXEYukQL4bco8mAtddaFX1jPGQinr+FqK7QMWB3IWYDFHlbKOMGzpKPOL
         8+rh0Ca0roNtQWua5XHYw5s7xceEJv4BZLLqdwATMSNlY5So0tqrxweKhED6TH0iSJgH
         bMAetctR74pc6Uh2kFtO+mI9DRoHPR0rFTKlWV+6jQSYmWQTem3gey9N+svmcA3d3SI4
         j8zMcgA7IzsIGk14SQTZ16BpqHJLkQgIaryYBHjCTP+Np4TrNjtnsRBwEroATw3KC3tT
         WEWQ==
X-Gm-Message-State: AOJu0YwpMrhZCE3/2UJd30CIKW3bGexds0kyzvGa78VSO83mCLD7UgCg
	agKEOiVLzuHzd7GkQVbuQoPRXrYvuWRui7mGkNCYnYXFKkXJCmxjBjIqL+GI5Qp3/6d6irjYE8R
	pD3tSZeKokRLJL9CYrIEA8+YnrjTbHrgA7z2l
X-Gm-Gg: AfdE7cn6Ll0PDd/sp9e+WdnK1VZw74Etksh/PWaZTk1gK70AnxQQbkeJakqa+mzvvlX
	SiUMneclyOi5RHkfOvyNHiiUDMYtryIonDqdYBmMy21p2qi2xrdrb/irnXjNNsxkLsJkKnjzD1x
	nmV21y8dHJtglYcDT+dYo+Jc10EQVnLIGIayRbaBZBraJYUn+mV0mApgxYUnRCu4jBJPhGd+u5/
	x8Tnc38xSJc3Zw/Xf+cmIewvc0/NeDYvdsS+4+qNArAJ2IoSq6J0AfYU6NdyWOVqxWMciFTQLk2
	Qda7RXFVLH7QWMafZZTu7VHP+cNa9habn55oa878zYDpGKJLn5jFDZMtSiApfWUk/3ttVYmuLhK
	rGCskcKOH0g==
X-Received: by 2002:a05:6512:3c90:b0:5aa:753c:d8d2 with SMTP id
 2adb3069b0e04-5aea1f41685mr1232020e87.17.1782394765560; Thu, 25 Jun 2026
 06:39:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623091008.1046547-1-maciej.fijalkowski@intel.com>
In-Reply-To: <20260623091008.1046547-1-maciej.fijalkowski@intel.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 25 Jun 2026 21:38:46 +0800
X-Gm-Features: AVVi8Ce4AOVQRSewG-fz9uEpHoqOhw7FutDh6vfdNCI-T3sJ1cbdoK4T5udzXc0
Message-ID: <CAL+tcoAosQzMo+4YJ-F_4SJaos_gRpQsQRETYPqBS_hJzan4sA@mail.gmail.com>
Subject: Re: [PATCH net-next] selftests/xsk: preserve UMEM view in bidi test
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com, 
	stfomichev@gmail.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	tushar.vyavahare@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:maciej.fijalkowski@intel.com,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:magnus.karlsson@intel.com,m:stfomichev@gmail.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:tushar.vyavahare@intel.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301963-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,intel.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 92CDC6C6317

On Tue, Jun 23, 2026 at 5:10=E2=80=AFPM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> The UMEM state refactor made __send_pkts() use xsk->umem for Tx
> address generation. At the same time, the shared-UMEM Tx setup copies the
> Rx UMEM state into a Tx-local state object and resets base_addr and
> next_buffer before configuring the Tx socket.
>
> Passing that Tx-local object to xsk_configure() makes xsk->umem point to
> the zero-based Tx allocator state. This breaks the BIDIRECTIONAL test onc=
e
> the roles are switched: the same socket is then used for Rx validation, b=
ut
> received descriptors from the other logical UMEM half are checked against
> base_addr =3D=3D 0. With the new UMEM bounds check, a valid address such =
as
> base_addr + XDP_PACKET_HEADROOM is rejected as being outside the UMEM
> window.
>
> Keep xsk->umem as the shared/Rx UMEM view used for socket configuration
> and Rx validation. Use the ifobject-local UMEM copy only for Tx descripto=
r
> address generation, preserving the BIDIRECTIONAL test's intent of using
> the proper logical UMEM half after the direction switch.
>
> Fixes: b17631032769 ("selftests/xsk: Move UMEM state from ifobject to xsk=
_socket_info")
> Signed-off-by: Maciej Fijalkowski maciej.fijalkowski@intel.com

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Thanks!

