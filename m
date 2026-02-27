Return-Path: <netdev+bounces-261906-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGRRN3C8oWlhwAQAu9opvQ
	(envelope-from <netdev+bounces-261906-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 16:46:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 651F81BA383
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 16:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E81D23194C0D
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 15:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A0743D4EA;
	Fri, 27 Feb 2026 15:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JYnthEPc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C781643DA31
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 15:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772206950; cv=none; b=bxfJbwgnUg5kphiW1BojSbI9gcBC/GrPk6DdB/Mc8lCal57A35F5mdt3rLSvNLzfi53vLPXSG0f8nDTpE1/xThlv7IdBFdg8jbXHIGqUV8y0d6LOPW5XpTOgCftcn1Tk+nbf+xqofhVGreO/sZYGxnIoSuzrKCf6Bxm3Wn7iaA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772206950; c=relaxed/simple;
	bh=xNmPC7M6iOz+4IQFF+f1ZCDlp2jKF0rJQSbdXK25G/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SrxI9H2hCjSuYuhKaMdAPXql/OPUmu+R0VKU+O/sqMtL7nwk6A+JfOS60eOwFKUBSQA9WDlucQHi2qUyAAz3Q6fR5nw8I+IknGy2d4Dch3UH9GQv2fCWOLdFATmEAXQxZuJL1U38JkKD+pbVEwYusWrs8pMLVhQLWsjzoKP6OB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JYnthEPc; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4806b8fca44so2958675e9.0
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 07:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772206947; x=1772811747; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XHBV2WlEb8YlpAeS8vaO1JmiPasxSaE0UWxp/WI+MZ8=;
        b=JYnthEPcTPfItXrpBK21KAq2vgeJlDmuakvlK3nUqh+ylkMolQYrwpHY0YObSlDnWM
         0CUdKVgyPBqn4vP6/OxLlaueXf/hSzwVK/cJCg3y4UkXrjP37mPw5iWqZsCnEN4zsBlv
         cgAoUh0DSH6/8DX+atEFUc/i6qxWQRHmnYOnh1prJkdKbm0X6eXUm8+Z2AvHNpitTdi6
         IttFtnwt3Iv0wy4btx8I5ATi3El6oA4xBILZ1rUO1eU8fodcofYGQPH1b5PSVjBrsLga
         mcszq7tcedeZOvQ5Lx6dGdziRI9G/f0hcSRhjtBC/4W5Lr4FAfYoyZ1NzXc1Sma24oUJ
         CYZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772206947; x=1772811747;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XHBV2WlEb8YlpAeS8vaO1JmiPasxSaE0UWxp/WI+MZ8=;
        b=spgJz6gRvpFdAsY8cfnn9JCTfCIzqA68KlrGn+nG1ijbrmcIxL8PZmVG/FQF89MNSg
         qJKR0v2c8eQdopuNpS4lCcwimvq0kjtF5oUfjFK0/9A2nq3uoXYv1umaEv99XVbgE84d
         +9CsUCsEf6rKxXFFpJp/HetOBz6dSYke2wCzWw6XxwGddGspI/B59A0y4NJcL8we1Rjt
         odqgHCDjSpyTTB5PM+Q5zwXwy8JIRlUiZS5bH53ClUqQgJjkB7WlqBOvXGPI25oLu/5m
         1BmVxRDhV2+AYaibS5GcKZ/6mpK0P6SN1zuw07KuI7G+fW0Pdo9+f3k2hRGUklL7+7Aq
         UzNA==
X-Forwarded-Encrypted: i=1; AJvYcCV+65ANn16NpKvStXeEU8WqWusV6cM4j/ptq0zw/V8D7T56KnvBA59oV47WFuGjCF89EsSwonQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMbLfnln24KVSPANaac9d0ZB/qKoYTEWJ03ax3chcaaR+3H++Z
	M+YLANYur/HBIPnCG52pfb6n3BZlZU1bDOYQaUUzc0bajKETL5IJeDxzrvFv8w==
X-Gm-Gg: ATEYQzz6qxDzRphJoaovPow0CRA/sVrkuS7sI6D2U4S5xm5bNCDg9wLo/Dl7TdstZ7J
	tt2dATrtv9TUG05V3P2+zJMQswCvGrtOAr/VZLYBZvW+E4cAm4PmgU0M/ZpOczgChIUo2thjuAp
	Ck9xzbP2GLAI4YQwH8gWfFSi4AOOkMZGFaGBqdvWNzVxFCr3uu60NMTO+KzG/JJQq81ZIE+UfD7
	zoNXaxlm0CQWGknEQ/NN+ZaYGwc3uUoVVzSnSjQFDVGl9FBAoxi+J7jd9rI75R/q7RQkaMD80ed
	mT3NxAXoEmaeQ9uGbuUcDEIO2z5qdztmMUCMw+fCoZOwNPw9GvFj6imNhiK9Zc8Qxp42idZ14Ev
	F8PJPTc30ZTL0dermK5whjnjuwbuLCv4PydOVVUzZa+iSNohFTk78GyiY76qrFpnBRecm4/l30L
	vbM5kw0zIWLVLS7A==
X-Received: by 2002:a05:600c:4592:b0:46f:ab96:58e9 with SMTP id 5b1f17b1804b1-483c9b7fadcmr29575125e9.0.1772206947165;
        Fri, 27 Feb 2026 07:42:27 -0800 (PST)
Received: from skbuf ([2a02:2f04:d608:3a00:ac95:d4c:390e:fb0a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4399c60f764sm7600585f8f.3.2026.02.27.07.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 07:42:26 -0800 (PST)
Date: Fri, 27 Feb 2026 17:42:24 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>,
	Neil Armstrong <neil.armstrong@linaro.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH RESEND2 net-next 6/8] phy: qcom-sgmii-eth: remove
 qcom_dwmac_sgmii_phy_interface()
Message-ID: <20260227154224.erj32n2kmwvv5xgl@skbuf>
References: <aaDSJAc-x2-klvHJ@shell.armlinux.org.uk>
 <aaDSJAc-x2-klvHJ@shell.armlinux.org.uk>
 <E1vvkUN-0000000AuPR-2qKj@rmk-PC.armlinux.org.uk>
 <E1vvkUN-0000000AuPR-2qKj@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1vvkUN-0000000AuPR-2qKj@rmk-PC.armlinux.org.uk>
 <E1vvkUN-0000000AuPR-2qKj@rmk-PC.armlinux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261906-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olteanv@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,armlinux.org.uk:email,qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 651F81BA383
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 11:09:47PM +0000, Russell King (Oracle) wrote:
> Now that qcom_dwmac_sgmii_phy_interface() only serves to validate the
> passed interface mode, combine it with qcom_dwmac_sgmii_phy_validate(),
> and use qcom_dwmac_sgmii_phy_validate() to validate the mode in
> qcom_dwmac_sgmii_phy_set_mode().
> 
> Tested-by: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

