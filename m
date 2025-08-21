Return-Path: <netdev+bounces-215626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D87B2F9A2
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 15:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 480947B3AAE
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 13:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E41322C64;
	Thu, 21 Aug 2025 13:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="rcM4x1KV"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834AE322A20;
	Thu, 21 Aug 2025 13:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755781933; cv=none; b=H96ox7ItW9+KTHd5IlGQuVFLIRDO0LGuVP09eurDG5oIfZP7y55ODtwcbuvQ0ywDXbklupdD2YeoNea7f9t9RhwFZuO0Gm+ioSo7dsmajYqVqAR4fy7JfBOGmU7/c9oQr3vdY25xNZA0vbox/TWOii56+cYBAF1MXGSWsYHnfHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755781933; c=relaxed/simple;
	bh=BjPmNCirEt5MeSPvexVQc+JfIxTKQcOfoq0gly5s6Ao=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bAR+d/3fD/7iwAttvb18MAyQ6RSAwWYSeCktZ7na4BcO5LCijGtrsMtibXaC1apNvqkuPMRu9PAxuFK4yMV4YUB5buc+QVoDA4rjGPSgBNlshEUtqhkanHUeutQqYdzVe4mPg0i3znjJs9XIIl3MnLwwsTsZ+08HHsqweB5EWjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=rcM4x1KV; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1755781929; x=1756386729; i=efault@gmx.de;
	bh=/NezXzD1z1MKuisNaqMU2PG+CDYEaJuVkby3d8pkrfs=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:MIME-Version:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=rcM4x1KVp+f0qYdF6ToBydXOURhjjdGV9N5lU2KK973kmyWOrzATaCexjVBoQMR/
	 xmk90mervtZUzTnJiBDbI41DlVosIoOhjDRmOM/7KLr4w0lFZSpOHVdzVupy7N4IG
	 LmIklyrCk2t/AvCiBW9ED1XXH2zKWcY3RW+HGM2kiBpaDoVoWK/glRM+ZK8/XNDGw
	 Ut5TNFkExIuJYVMaPIHMXbirW2QK8i9bmTBwYfQON7k6615MSLmG7r9hSczx7JWao
	 xrveCh+JS45jlbg2jxrIj8VUMmFi3nnXzNixPrlPvUMmeS2vX/lFgr2Za5wyXlxc3
	 YyuCcLoPUX8mo81RqQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.146.50.96]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MfpOd-1uMJqe1vFR-00f4Kc; Thu, 21
 Aug 2025 15:12:05 +0200
Message-ID: <fce0dffe6692b17eb41942d2fbb7c7aea05d8df0.camel@gmx.de>
Subject: Re: netconsole: HARDIRQ-safe -> HARDIRQ-unsafe lock order warning
From: Mike Galbraith <efault@gmx.de>
To: Breno Leitao <leitao@debian.org>
Cc: Pavel Begunkov <asml.silence@gmail.com>, Jakub Kicinski
 <kuba@kernel.org>,  Johannes Berg <johannes@sipsolutions.net>,
 paulmck@kernel.org, LKML <linux-kernel@vger.kernel.org>, 
 netdev@vger.kernel.org, boqun.feng@gmail.com
Date: Thu, 21 Aug 2025 15:12:04 +0200
In-Reply-To: <bf39250ebfb25160a5ce0abd9ce694f07cab8433.camel@gmx.de>
References: <fb38cfe5153fd67f540e6e8aff814c60b7129480.camel@gmx.de>
	 <oth5t27z6acp7qxut7u45ekyil7djirg2ny3bnsvnzeqasavxb@nhwdxahvcosh>
	 <20250814172326.18cf2d72@kernel.org>
	 <3d20ce1b-7a9b-4545-a4a9-23822b675e0c@gmail.com>
	 <20250815094217.1cce7116@kernel.org>
	 <isnqkmh36mnzm5ic5ipymltzljkxx3oxapez5asp24tivwtar2@4mx56cvxtrnh>
	 <3dd73125-7f9b-405c-b5cd-0ab172014d00@gmail.com>
	 <hyc64wbklq2mv77ydzfxcqdigsl33leyvebvf264n42m2f3iq5@qgn5lljc4m5y>
	 <b2qps3uywhmjaym4mht2wpxul4yqtuuayeoq4iv4k3zf5wdgh3@tocu6c7mj4lt>
	 <4c4ed7b836828d966bc5bf6ef4d800389ba65e77.camel@gmx.de>
	 <otlru5nr3g2npwplvwf4vcpozgx3kbpfstl7aav6rqz2zltvcf@famr4hqkwhuv>
	 <d1679c5809ffdc82e4546c1d7366452d9e8433f0.camel@gmx.de>
	 <bf39250ebfb25160a5ce0abd9ce694f07cab8433.camel@gmx.de>
Autocrypt: addr=efault@gmx.de;
 keydata=mQGiBE/h0fkRBACJWa+2g5r12ej5DQZEpm0cgmzjpwc9mo6Jz7PFSkDQGeNG8wGwFzFPKQrLk1JRdqNSq37FgtFDDYlYOzVyO/6rKp0Iar2Oel4tbzlUewaYWUWTTAtJoTC0vf4p9Aybyo9wjor+XNvPehtdiPvCWdONKZuGJHKFpemjXXj7lb9ifwCg7PLKdz/VMBFlvbIEDsweR0olMykD/0uSutpvD3tcTItitX230Z849Wue3cA1wsOFD3N6uTg3GmDZDz7IZF+jJ0kKt9xL8AedZGMHPmYNWD3Hwh2gxLjendZlcakFfCizgjLZF3O7k/xIj7Hr7YqBSUj5Whkbrn06CqXSRE0oCsA/rBitUHGAPguJfgETbtDNqx8RYJA2A/9PnmyAoqH33hMYO+k8pafEgXUXwxWbhx2hlWEgwFovcBPLtukH6mMVKXS4iik9obfPEKLwW1mmz0eoHzbNE3tS1AaagHDhOqnSMGDOjogsUACZjCJEe1ET4JHZWFM7iszyolEhuHbnz2ajwLL9Ge8uJrLATreszJd57u+NhAyEW7QeTWlrZSBHYWxicmFpdGggPGVmYXVsdEBnbXguZGU+iGIEExECACIFAk/h0fkCGyMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAAAoJEMYmACnGfbb41A4AnjscsLm5ep+DSi7Bv8BmmoBGTCRnAJ9oXX0KtnBDttPkgUbaiDX56Z1+crkBDQRP4dH5EAQAtYCgoXJvq8VqoleWvqcNScHLrN4LkFxfGkDdqTyQe/79rDWr8su+8TH1ATZ/k+lC6W+vg7ygrdyOK7egA5u+T/GBA1VN+KqcqGqAEZqCLvjorKVQ6mgb5FfXouSGvtsblbRMireEEhJqIQPndq3DvZbKXHVkKrUBcco4MMGDVucABAsEAKXKCwGVEVuYcM/KdT2htDpziRH4JfUn3Ts2EC6F7rXIQ4NaIA6gAvL6HdD3q
	y6yrWaxyqUg8CnZF/J5HR+IvRK+vu85xxwSLQsrVONH0Ita1jg2nhUW7yLZer8xrhxIuYCqrMgreo5BAA3+irHy37rmqiAFZcnDnCNDtJ4sz48tiEkEGBECAAkFAk/h0fkCGwwACgkQxiYAKcZ9tvgIMQCeIcgjSxwbGiGn2q/cv8IvHf1r/DIAnivw+bGITqTU7rhgfwe07dhBoIdz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Provags-ID: V03:K1:KJ4k0twi1HJiomo35FK08kNZ9nnrG5S8UdvXGo+HGbeG9kVBEet
 wsoElsNouP52Jewb4bGhAwpUNgHfDPi0i/sGiSaD+9e22TZCvroAxnnmVmCSx5yyOZD+DTg
 DJ7y2TsV+K3uV1opvbGxwOfGK5bddX8j3nuMbQ464hm3+PY+qpyuApCZtLxpgowqKzgFySX
 5Ccd/lMdUaShjw8OWLttg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Fnqmgvk1wCU=;o7OzdntEva/gQQzW80fmQF+CDwN
 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

On Thu, 2025-08-21 at 12:06 +0200, Mike Galbraith wrote:
>=20
> A quick test proved you correct as to the why.

After a bit more testing/twiddling, seems NETCONSOLE_NBCON could
improve things at least a bit for RT. I was able to cleanly log an irq
thread handling sysrq-c over a wired interface.  That beats silence.

Wireless wants more than a wee twiddle w/wo RT or NETCONSOLE_NBCON.=20
The path of least resistance there is bounce to kworker.  Oh well.

	-Mike

