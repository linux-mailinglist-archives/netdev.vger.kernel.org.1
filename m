Return-Path: <netdev+bounces-241494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ACFE3C84750
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 11:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 26FEF4E9667
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 10:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473DD2F5A08;
	Tue, 25 Nov 2025 10:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="jdkvyeoz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9221A2EDD69
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 10:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764066107; cv=none; b=uxrr8fVne5Tp6pc1mzLRAeN9cvmk4EJHQb+6ULbOnqVnHvvYEfijii1EdCRh4N2i2niGm+LPjMSf9ou5+jmVYE5OIqZVSPfDIz5flmSOfaSh9NfAg8OHznMPtBxBerAntQupI7fBEcTlJr3IbA7nJGilbRrdxYFbzAtTV7WZR7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764066107; c=relaxed/simple;
	bh=+rOwk2RA33dF4WiOqSAVuKiVTIehuiVNfhftsKo0a7Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cG4wdqWQSvR65GC2g1oKBbSitq6vZjIy2mPhHQZ8RWDOE02K/Fg5cngC5B0JkLURcYD6Puw4kkp0Hmk/oT7B3YqCZu7glehPnatf8/J0cJkyIs7VdhKMCBiR/u+8Uugoag73mrF3C/fW5KuagUQ9n0svyULxULR4rTuVjuYD9nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=jdkvyeoz; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-42b3d4d9ca6so4322235f8f.2
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 02:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mandelbit.com; s=google; t=1764066103; x=1764670903; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=usqUI61O5uSfjYi62jMQ9TXpUJFFLlygNvx27CjAFUM=;
        b=jdkvyeozp6FBewcmin2f+Ojw7B+yJhFxvgWS5HHQXq1juPMHYF4hLczdsOYn5hGQEb
         dRKDsvKOaC1royyzmAHsONXC3Jl9t2JLdKaSzGrWsIssbzPZD9b6WtN/RKy05AQCr8Y/
         sxjBFY6RZUKHkT1a04HrQVp8DgHfDE6WZ/OC3TZ3VWwxxHWtyXKn3NSBrVWg4mv6+aOY
         trgcjCUglASxEQSRiBsIhrMepSHFfo+n72s82o5w1xrxK64gDNN5V34iVJ1mkjqkG+UN
         1FW+K1M6oeEpLYceCRgtCJ5toQVCPrwaa3dZgCZ1ozzc3R74jwkklXn5nRqiSXHiJCfV
         xjHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764066103; x=1764670903;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=usqUI61O5uSfjYi62jMQ9TXpUJFFLlygNvx27CjAFUM=;
        b=p5fn+K5BRt8h8rP0yLNGuvuZNU3/f+B3O4SKqWrHhlmuQ6WkkccXGQmOLbiHzNlmu2
         BKFfrM8VyEZT0qrm+P8TKRnxoeetwJkKGaTNuw0EieEFazWHPaUpKRjTngKb06Yp0q3X
         hCZKIRVhlaYsCaiR0iuXVGJt32deDiVAfHj+kCLl4VQJQi9GfSPC7bpqhW8TH5DPFu7c
         8C3Nx9zvLO8uvUqwxXF4blNjKxLzN4dGQDP6ZrBJLhyd6bh/5FSiDtvg4EGfGNkJIrnz
         3JZErgHf0vCDTowEPG7bXrtnJJAwx4/GhTdh9eVFv7ZLdBWbRxdzUJAraLjPKETxZWt3
         TpPg==
X-Gm-Message-State: AOJu0Yw39FminJOuC74u3lOEvmu4UY/FyrlmtPKB/MlcXzQgsVtNjzZq
	R0iKQAr7zaM6F9WQHjMTkCgjb3e5bRrTEA9+7YUcuA2JIU8QLFjD2E9HHKF6Cg/0cuN2u6MBIW9
	awBRwEpE=
X-Gm-Gg: ASbGnct0+lnPfW2S9fDoTokSexizXFtEIt00VPN9GaNnlfCBaWqGtjjSZt1kXClyB3N
	mH5ivuYud/tv3Lt8NSrXiL7ND8Jatf3jmbbfBPeDEV8S60Kbxm5f9OwwCCn2tmostfbixa0IuJ7
	P05S6HpYS8xVZuzBHDEISicBTT7QnAApjBhtMxDUinIrW6NEhKLQw9bjvRtYjjjDhZtDms1noY1
	nmglSFUbnK+1I3EIOwDVFau2/ZoI9D0JgwSKCuvD8FFRFd4q86IDthieFxlJ1cA8j3UBgRwtuBU
	b9/6cPOf47ngwY1SJ40rh/G78G5sxKeOlKqulnYXwBVKkK264CQ8z1O2GZMwZFa1TFnDw4SaUjo
	9PVDbo0GEKuJ6Aq2jiN0u2BnvDWt7M9tb4RhKUdDSPcY8BPDfKpbqaaL+K8eM0ORICSGFsrXezY
	cGGTEDlOWGfsreGoYDKB6MWN7hPeKMIgjtIEPXBbyMH3KFVWJy0Pr0G76MhlqxXquJPqgL
X-Google-Smtp-Source: AGHT+IEKq67HVyAxXm2ukowHdBKE7/qTnckkb26kV1Fs3NCGHtrM7e7hMBSQbvVfFDTOevRhJMgmpA==
X-Received: by 2002:a5d:5f44:0:b0:429:d350:802d with SMTP id ffacd0b85a97d-42cc1d34848mr14714622f8f.45.1764066102726;
        Tue, 25 Nov 2025 02:21:42 -0800 (PST)
Received: from ?IPv6:2a01:e11:600c:d1a0:3dc8:57d2:efb7:51a8? ([2a01:e11:600c:d1a0:3dc8:57d2:efb7:51a8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fd8c47sm34796036f8f.38.2025.11.25.02.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 02:21:42 -0800 (PST)
Message-ID: <e6a3845a7522e692fa3de69ec7f1f9c9a683223e.camel@mandelbit.com>
Subject: Re: [RFC net-next 02/13] selftests: ovpn: add notification parsing
 and matching
From: Ralf Lici <ralf@mandelbit.com>
To: Sabrina Dubroca <sd@queasysnail.net>, Antonio Quartulli
	 <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>
Date: Tue, 25 Nov 2025 11:21:41 +0100
In-Reply-To: <aSR--l90hvP6Fkld@krikkit>
References: <20251121002044.16071-1-antonio@openvpn.net>
	 <20251121002044.16071-3-antonio@openvpn.net> <aSR--l90hvP6Fkld@krikkit>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-11-24 at 16:51 +0100, Sabrina Dubroca wrote:
> 2025-11-21, 01:20:33 +0100, Antonio Quartulli wrote:
> > diff --git a/tools/testing/selftests/net/ovpn/common.sh
> > b/tools/testing/selftests/net/ovpn/common.sh
> > index 88869c675d03..b91cf17ab01f 100644
> > --- a/tools/testing/selftests/net/ovpn/common.sh
> > +++ b/tools/testing/selftests/net/ovpn/common.sh
> [...]
> > @@ -82,6 +99,23 @@ add_peer() {
> > =C2=A0	fi
> > =C2=A0}
> > =C2=A0
> > +compare_ntfs() {
> > +	if [ ${#tmp_jsons[@]} -gt 0 ]; then
> > +		[ "$FLOAT" =3D=3D 1 ] && suffix=3D"-float"
> > +		expexted=3D"json/peer${1}${suffix}.json"
>=20
> nit: expected?

Will fix, thanks.

> > +		received=3D"${tmp_jsons[$1]}"
> > +
> > +		kill -TERM ${listener_pids[$1]} || true
> > +		wait ${listener_pids[$1]} || true
> > +		printf "Checking notifications for peer ${1}... "
> > +		diff <(jq -s "${JQ_FILTER}" ${expexted}) \
> > +			<(jq -s "${JQ_FILTER}" ${received})
> > +		echo "OK"
>=20
> Should that OK be conditional on what diff returns?

We run selftests with set -e, so if the jsons don=E2=80=99t match, the scri=
pt
will print the diff and exit. That said, I agree the current code isn=E2=80=
=99t
very clear, so I=E2=80=99ll make the "OK" conditional.

--=20
Ralf Lici
Mandelbit Srl

