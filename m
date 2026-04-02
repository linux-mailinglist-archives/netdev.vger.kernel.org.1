Return-Path: <netdev+bounces-274538-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCE0OhNrzmmpngYAu9opvQ
	(envelope-from <netdev+bounces-274538-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 15:11:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F48738975F
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 15:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 381F0317507F
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 13:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97853C1980;
	Thu,  2 Apr 2026 13:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="J+UGWKxa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153ED3A0B01
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 13:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775134947; cv=pass; b=hwjDJxEe9kKTAsSqm/QiuaVlzN2N/socivCbTAWpNFKwFrcTFYMFSUYqrBuuVCxZUC3Nic4l9fagDtCwvUQe03O5h4YgVPkLJFjGPYOnfP6HG0A4Bqe6zODXxb3Y8AO7yCT7kEljmhnXMFNtVfvvGzoEeqcRM3CZ/TEZKwlBIDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775134947; c=relaxed/simple;
	bh=Qzc7zthmCYDmHkDV8148S1eMSVXY7cYeD7JUEBigKIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vAvgOmrWK02cUPHLIltXCNfe8rB6uG11UmGEISMsNcgCBj7Rv/QZkMdgHuLkdFtQfQRxgdGDs3b25UfZAYkLU3bhs276eNgfwxVlHx8PrXOrkjU8CkdKZF5M02xcygO80D5V1Ww4RCQuNZv+kXxL0U1/YKFACarIN9Okr8ZHBDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=J+UGWKxa; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5a1307438ddso1009835e87.1
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 06:02:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775134939; cv=none;
        d=google.com; s=arc-20240605;
        b=NyoT4cXk1oeL9aRcDSWBW3jFWAtclxUqZyNbi4YShcg8xrWb/GdykOkQ71wEqPNCv2
         oqVpB1xcQUg7waTRhlOtsBVz/bLXGQRPmgMfUiG/O0fE5z4xhc9YcdqV3T8oU9Cun5WB
         Y0SKk5L1kYcmdkHW3eNzvL0S/UMyQh04d1Qr9xxtyFUK7vbQ493XbqR6Uhm5v7m/ymHe
         PbrCzG6mxtCTJGXwaYAabMzMsE4paJMBdU0mVOOZiYPyZxQJGvQZp+lhjCbgpRELtOCO
         LZR2uzzQix7IRRBJ6zej3dmi04yTGzsbwRBlX0/D7zm2Cz4sJIe88PrpHUXuRFj9jMqB
         m/uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Qzc7zthmCYDmHkDV8148S1eMSVXY7cYeD7JUEBigKIw=;
        fh=4fyTB+bp/kXcY9YiDjX3Mtl5ckhzwr5O14omfg8tyms=;
        b=az7/Xcqbh4tWFyLhQpqS2V6pWAWj0YW73noP9IGKXwbQIr7zL6V2tukOMf/mLVTEMJ
         R65VAXTFJH3kqBA2J71efTqyD1MOlCQAiw/budsJWqebzXxLEPMwy9mzoPoxMJtpvSa7
         nDQN1WL7LE2djysdcmqm9+0iubqQKc2ZjlaOw4q3M3xmBJiJpqLANn/RgtcQ53iCjRJx
         4jtxhtQTiSrBwYZJY5RBQDQjUniMYvSnPNtSrNENyisXEoYJSjUmqRq1COzdW577cz5Q
         WWfSezp6jEpcJFizOEBnDN3JR5VNMuGb5aUMQ8zrC6nE4U/jvAsOK2Rc3Sd+x9Nsly6a
         72Nw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775134939; x=1775739739; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qzc7zthmCYDmHkDV8148S1eMSVXY7cYeD7JUEBigKIw=;
        b=J+UGWKxa9gFIeVOfgyYjqFc2Klnn4vVyoh+sBlmmFEQQMePK3Ksiq6BvA3AGfP2AvZ
         yBUfl4RNIis7nOCgaWLdBChpeuNixJRSzMSKnnN9DKUEr4jlSptdvn4pmWg+EHn40pic
         2qZhtvXQwiY0dlQ7eEareCLAnasuREFBZTrQI//E4YrZK0vaCJcjR21qo6Q1zLADVxqN
         FzeW4SWwVt4DbERUmCxdyDkE5DPJ2EU00dDjn+UytYg7Ap+99dhDor+Npt0JT1rnf3yx
         WOVfF36DheFQRgByGhognpg1krBLXtDwAOMxBpEfyil8xF7HW54090I8/jWI76zx2N70
         EXcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775134939; x=1775739739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qzc7zthmCYDmHkDV8148S1eMSVXY7cYeD7JUEBigKIw=;
        b=YR1J9XlcBTrotSvaDtL0jQ4xMFh8lz0LNBkhUIM9i/Pw7y1cXAZORkXBwIzxEld126
         ZUuEW+D9co7MOtn3Qqkx2SdUyefLJvenFHxJRWuTE4CUwXDM5KztbRX8B4EXxARXKDxL
         AbmI9VZsjSGPRBhvXjhpAMqth+i3/kYRtN0tPMw8ygssMFKT4zyBP5OskkC4PvoYwS8C
         Cq2Tjo4GjltnZ5dwb1aA8qRwOkQhVsgCE1MNQjq6+RF8BOJY62DSR5vejWm14NZfSaq2
         STRKo1m2bDFvtdNF+kW89Cj3H6A087O7XTmAvXHOa4466JBnnR5aMWB7BJ+VAdpmOPnP
         n41A==
X-Forwarded-Encrypted: i=1; AJvYcCW7HSF+9KnhrEmdil1w0E0yKXTRuCpCdxGr7KZ5WD9dsoLoywdGMk3rWW3ZfTXQWHcVzVQi8O8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYSMAjXgbgv3jijbX8Za9aJmD7sCTB/6B7o46AXCjVXyXaIqq8
	ySejFjxiPpbql9p27v+Di+xe9fwCW37P0PEUkCLpW5w1PqALo7j0VlfSWJusD/xg/sckb06xbui
	2XhyYhdGNTZnR5WMVHiXq1OocVvFML2rjwp/HhB/yv2fcVaeV27oi8dM=
X-Gm-Gg: ATEYQzzYqfINirJYibjJvJZszwNVleuwe4YtCfMVhsbq7slm0Djv/EqYUUUWMiJ9LC+
	gnxwNBGWE6CagzEi2eio479XMkmJjBOTI/H7MKyWhk2tc3TtvhHMJlFXtLVRX4gesHzmhcBTPPG
	F8SPFo65KqpD4z9goAwFW8wOH8Vi+iXL/QNfTc4FpDNhGTh/3Lp0YJJY/j712STBq+6YTGUAHCJ
	AArsfN4OGWS3sNbfwW9A3Xqw9q4jeKy5EZXhKtyD5kjA3ZqkD8MJxwzZRgrXV0Wc410ewWGzaJP
	3hIbU9lUxf5fMN7fEqau7of8BEsw9jQpLJRuiufX
X-Received: by 2002:a05:6512:3b1f:b0:5a1:2c41:d28d with SMTP id
 2adb3069b0e04-5a2c1ef9148mr3285986e87.19.1775134937855; Thu, 02 Apr 2026
 06:02:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260313150917.271086-1-marco.crivellari@suse.com> <0ca7f92b-ec4e-469c-ad2b-648d278bcfe9@intel.com>
In-Reply-To: <0ca7f92b-ec4e-469c-ad2b-648d278bcfe9@intel.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Thu, 2 Apr 2026 15:02:05 +0200
X-Gm-Features: AQROBzBiZA4wu4pRSlW9X59e1j0v4Yj6CRcsXbFsWbV4URy_HSPh_8aVJS8DgF8
Message-ID: <CAAofZF4X8sOHawQD_DO2CQFDHUdNrtNE9bT_aMEHgaUmwDC-6w@mail.gmail.com>
Subject: Re: [PATCH] idpf: Replace use of system_unbound_wq with system_dfl_wq
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, Tejun Heo <tj@kernel.org>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Michal Hocko <mhocko@suse.com>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274538-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[lists.osuosl.org,kernel.org,vger.kernel.org,gmail.com,linutronix.de,suse.com,intel.com,lunn.ch,davemloft.net,google.com,redhat.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marco.crivellari@suse.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 7F48738975F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 5:09=E2=80=AFPM Przemek Kitszel
<przemyslaw.kitszel@intel.com> wrote:
> [...]
> this wording kinda scared me, but after reading linked commits, there is
> nothing to worry about, as there are no functional changes in this patch
>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Hi,

Sorry for the late reply. Yes, correct: there are no functional changes.

Thanks!
--=20

Marco Crivellari

SUSE Labs

