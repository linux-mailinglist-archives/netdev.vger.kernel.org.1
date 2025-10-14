Return-Path: <netdev+bounces-229109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9DEBD8456
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 10:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2B8218A4DD7
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 08:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA88A18F2FC;
	Tue, 14 Oct 2025 08:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nRvV0Fza";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LZrzqOwc";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nRvV0Fza";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LZrzqOwc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E2B202997
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 08:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760431732; cv=none; b=KHe89kIrj2mMRbFbQsId+S5ge5KS3zR7NhpzH5MoVAzsRqRTEskE3aEuXP7Lf0PROgOQd5UV44es17AoUhPyyHkhF+GvjNr7mUNqqNv/mUz70dKnyH1/Uaxi25m++RBnKP1YVgQ5SkdysQehviOpkB5qygG+RoLdgIjghja+kI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760431732; c=relaxed/simple;
	bh=+RQaq5vqP59DNT8zkULHUKzCvsuMS8MlEztgp4oLc3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dsvnLDhgaW+IJVzfHSRxVc1SJikhHiVnAuxbC19ljYtZj7R0KowiZoB5IDpmikbYPvrRwpcnfBvmjvAh57Qm/clF9Yz9/+uVmpmrzMgCnF8momNB28Ho8I4jYC4jdExaZ3H1JiLx0wHx1H0ZahEEE/+tee2VIPfzLZiY7A4y8hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nRvV0Fza; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LZrzqOwc; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nRvV0Fza; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LZrzqOwc; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5517521E7B;
	Tue, 14 Oct 2025 08:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760431729; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YLfbWqw2DUKPdHxynRii/9hz+IfkKtwNMprspvuWD0Y=;
	b=nRvV0FzaigLhb8FuB25fq7kEgOqgNhIPtIZ1fpR5pEyu55IYWCa+xLK8TBmrz92geI0b7g
	nmtvPXQvnSVMJFNlBmDAKKQVTsjM66rKYa6XHlodt9R3c71weW2wd3dJa5iMeuh06DIAKp
	vplFazF0CNftGsT+naC4Ewil5djRNTc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760431729;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YLfbWqw2DUKPdHxynRii/9hz+IfkKtwNMprspvuWD0Y=;
	b=LZrzqOwcj27rzis2iqSLMOaFp6Y5ZSoXyIzmWviafx/cIetUSJHDT13dLKa/7uMPITJ/YD
	09cTMnnw0DlU+FCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760431729; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YLfbWqw2DUKPdHxynRii/9hz+IfkKtwNMprspvuWD0Y=;
	b=nRvV0FzaigLhb8FuB25fq7kEgOqgNhIPtIZ1fpR5pEyu55IYWCa+xLK8TBmrz92geI0b7g
	nmtvPXQvnSVMJFNlBmDAKKQVTsjM66rKYa6XHlodt9R3c71weW2wd3dJa5iMeuh06DIAKp
	vplFazF0CNftGsT+naC4Ewil5djRNTc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760431729;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YLfbWqw2DUKPdHxynRii/9hz+IfkKtwNMprspvuWD0Y=;
	b=LZrzqOwcj27rzis2iqSLMOaFp6Y5ZSoXyIzmWviafx/cIetUSJHDT13dLKa/7uMPITJ/YD
	09cTMnnw0DlU+FCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E512313A44;
	Tue, 14 Oct 2025 08:48:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AJ4ONXAO7mhKKAAAD6G6ig
	(envelope-from <fmancera@suse.de>); Tue, 14 Oct 2025 08:48:48 +0000
Message-ID: <b25a73bf-1309-4f9f-9cd7-795e0615635b@suse.de>
Date: Tue, 14 Oct 2025 10:48:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next] net/hsr: add protocol version to fill_info
 output
To: Jan Vaclav <jvaclav@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <20251009210903.1055187-6-jvaclav@redhat.com>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20251009210903.1055187-6-jvaclav@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 

On 10/9/25 11:09 PM, Jan Vaclav wrote:
> Currently, it is possible to configure IFLA_HSR_VERSION, but
> there is no way to check in userspace what the currently
> configured HSR protocol version is.
> 
> Add it to the output of hsr_fill_info(), when the interface
> is using the HSR protocol. Let's not expose it when using
> the PRP protocol, since it only has one version and it's
> not possible to set it from userspace.
> 
> This info could then be used by e.g. ip(8), like so:
> $ ip -d link show hsr0
> 12: hsr0: <BROADCAST,MULTICAST> mtu ...
>      ...
>      hsr slave1 veth0 slave2 veth1 ... proto 0 version 1

I think this is missing the 'Signed-off-by' tag. Other than that, it 
looks good to me. Not sure if it can be added while merging.

Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>

