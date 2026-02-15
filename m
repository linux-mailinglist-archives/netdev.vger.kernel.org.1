Return-Path: <netdev+bounces-258763-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAWVNlCTkWkzkAEAu9opvQ
	(envelope-from <netdev+bounces-258763-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 10:35:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA7313E65C
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 10:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BA5A93003606
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 09:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCEC6227E83;
	Sun, 15 Feb 2026 09:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fkg457uI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B4E2066DE
	for <netdev@vger.kernel.org>; Sun, 15 Feb 2026 09:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771148110; cv=pass; b=Xa0IdvgsV+iz5spL94ReLgtKV0qkMIo9K+0MlUTbcvW9x3HFFhBHEVKITg7Fc5S4FkiqO7unOBKsBkwZp5t2B4aFdpcL0jvh1zwwn5H6l7VbNecLCl4sKJLy79oFhd6DqR4S1tdjKRBVaGxNbBTqMffI36m9L8H1TO5w5etoLHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771148110; c=relaxed/simple;
	bh=h1saT89qRRncnD/4b+teJLDKipslTZjWpku9l2q/pzs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zdgiiytx8dUPhfc+DWXnWAF/8HoSLqjZf797MTwanSZqFg3aNlLwT1sr7W0dFBzYl0zydfZ9iTYmEm/7o2IygdZwEZIJR/q3XkbSkytkf//wgH/NG7ZJYCSANVrcer+vWvyHzYKQXwfr/Gi4GMdPLKriPvaNdwsJXDKCdcJ1Kyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fkg457uI; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-506aa68065eso18598041cf.1
        for <netdev@vger.kernel.org>; Sun, 15 Feb 2026 01:35:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771148108; cv=none;
        d=google.com; s=arc-20240605;
        b=JniVr8Of15jAm5SRLg2W9xjBYyMFZkg6ev4pG9EL/qSPLsDua56m2yQDafRKmuI5Jb
         5sSU0YMIoNUKyh59gplIB3Y5cVMoyciCfsNW24RYKsZHK9qj9jFEWCCsxcCaFFoW/LTF
         tH7iBqZIZ0ObLyUA5BEXeu6TPBy9FHMeIskTvi4K7q6VN8Lrmsn/ecn4oDU8GBngSkiP
         iwdFYd93quwmC+5LN6GgzewSJuZ/QHq11bb/YBv89cZbJR2JivYBo7Bd+T43a4dHxL2Y
         O8Bkuk9e6W+Jt2cfzzEo6pVbWx6uaZMZJ0FVgHOphy7X0yy9jrkjks1A1zpdUbOSePQG
         SlYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h1saT89qRRncnD/4b+teJLDKipslTZjWpku9l2q/pzs=;
        fh=CsbECOXfgPy9iTX3epOJBfZPXg5+LZHyukbLr0aBROw=;
        b=WXJWuSTyrt+PI252umbJddwfEt2GKwFtR7ayUT5Lf/O6+Bsjh4+bCQ3Kh6DvQTaxch
         i2+zRTk54r/CwgDETYc2cY/OhdWUq/O8khCUs8PRw9XRZUwNfxKqNdBxxFenR3Wplpd2
         vuXL2yUrgnr4FOWqZ4WRqt6bpXFXTNFr5tQRC3KmRZK0xQpXbnH/gn6hQqQ5XMB3MoSV
         cHhT0Vjdpc0mxs4tN1yx2EBxFA74YTjDMQLW7o9L7jnT8tSNhxRG9GyfTctHsCnsRt45
         hNbBpoINkA+YJV0sCcjqY0gB0W8el2ri4JSraDdsqg9FHxxELZ8vQnohTeiQuM0aMoSs
         h7jw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771148108; x=1771752908; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h1saT89qRRncnD/4b+teJLDKipslTZjWpku9l2q/pzs=;
        b=Fkg457uI9HCFS0p30ISTyLP01jZQYQ2RvQmyRlBhD/68kn+ddQdVn1/TBOpVK852+w
         +mYkHiUkREicnb+p2YWUTNNS3BneeoJS0rmhCnEdAdt7THElrRY3lJ5UztZ0beEDwmg9
         UAw30E1iTokjzEJxWr8Jz8u+Xca5GZJ3GyTHPqqlCbMtYMzfKSoYcwnpsoaecGffrWnY
         vb0VoLzUzD0/ZIFZSUerwwgdH6keVivnK6y9X8MkEhm3UtPPQgrQ6emaoBVnsyhhlA92
         0ibN51SL6Es8ozGARxbvk8ZsZWEriILcmy0/ZYcWEV91jAnx8peEl6bWxcjbqJ4IeiUY
         CjxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771148108; x=1771752908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h1saT89qRRncnD/4b+teJLDKipslTZjWpku9l2q/pzs=;
        b=OLnIwsUvLeOekuTYAEG6GF93fdbLoyJVmByCy5/Mq27rjO2YBRwyTFd3eDK81zG9+f
         oIcZMXSxV0l8BZjSkozHpdcPJrRMNYTkaPzvPUcFYwN6ZLAjbIxYXMqXZ1RxFA7tdN9N
         Zc8x8Ul2SU7vJnvYfOaPbFbxe4q8IB7LJMIKYCkwlDGCiGJmlCy5DvDj6wYRUx8zJ2It
         GxiFnKm1fj6gR9fhfpAbyWrw0ejOCqb8dj0tBKWAWzHTfzfeiEiv3H3fcixhn/1TM36+
         yYEqDtwAmji+colBsrFXxPBG393kGVpYV0tAhm2I9taTRJhBP9V6cflJxFNuwIAb4tIH
         MV9w==
X-Gm-Message-State: AOJu0YwOHq7p8vgEJgkTutBCv4Fd9071betxvaqB0qgmAYXygftWP+s6
	DADVKgp0EmOabFJZydHn58vJ02kRmc4X/nWeHShnmF37H1PWN5TrJ5dot/oig9tfJR+8OIpjT35
	j7Cid94u6FzmcaxaOQb/rNh+eggf6iRXvu3Z6CmOg
X-Gm-Gg: AZuq6aJTFehPyLuNG3vbO3GYRDi1pjHBIKonhsqw54cuwkBhQJfffBs/37WTLyCd9oQ
	zS/mNhyFYp+A35CSp6GAtt/xHRC9hq+ABTIYtWlJzgnKiucR+9lGBelyWn8BDDjJ3UXS6FvGIy2
	tRBjZK9Hlq5dKTn8Ddy0xeDanvT02eZ9Pqt2ljhzc9o9bQYWj7UO0JRrCmST2pqY3Q97EmN+oGU
	m9xntvDOEFno1F0y0UXpUr0B5fpaubgO24d8+lH4seGDscHgKSgbQMSx662btq2hH02ipgv65PT
	zvymQscL0vYAD8kProY=
X-Received: by 2002:a05:622a:1443:b0:506:a1a8:c6fb with SMTP id
 d75a77b69052e-506a8276e8cmr102888371cf.2.1771148108001; Sun, 15 Feb 2026
 01:35:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260214172543.5783-1-fmancera@suse.de>
In-Reply-To: <20260214172543.5783-1-fmancera@suse.de>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 15 Feb 2026 10:34:57 +0100
X-Gm-Features: AZwV_QgLqGKSh-k-xLjwej9H6Jtd_mRlNz8OkQqYVEo1426puc8ZD_nUk6L22rQ
Message-ID: <CANn89iL_vTzAaN7KvwrQ_Li_qD3xTcZwD0rDRrhZ4EA2p8NEzg@mail.gmail.com>
Subject: Re: [PATCH net v2] ipv6: addrconf: reduce default temp_valid_lft to 2 days
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, fgont@si6networks.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-258763-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.de:email];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Queue-Id: 7DA7313E65C
X-Rspamd-Action: no action

On Sat, Feb 14, 2026 at 6:25=E2=80=AFPM Fernando Fernandez Mancera
<fmancera@suse.de> wrote:
>
> This is a recommendation from RFC 8981 and it was intended to be changed
> by commit 969c54646af0 ("ipv6: Implement draft-ietf-6man-rfc4941bis")
> but it only changed the sysctl documentation.
>
> Fixes: 969c54646af0 ("ipv6: Implement draft-ietf-6man-rfc4941bis")
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks !

