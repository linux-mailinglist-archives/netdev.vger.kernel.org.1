Return-Path: <netdev+bounces-14789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A98743CFE
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 15:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEAFB28107F
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 13:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D150B156D8;
	Fri, 30 Jun 2023 13:50:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB540134B5
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 13:50:18 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2133.outbound.protection.outlook.com [40.107.94.133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA94F30C5;
	Fri, 30 Jun 2023 06:50:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hx+kzsZNHJTMgUBGoFVO3aG0clNYSJru+RMzvPLBS1vq5OAKwPzZyFNZPJGqVWfIBFGnu0DdnRH7hgXPvMsEuhEusp268d05iYqF8I4F87nfcveWpZ4WckYHQJoqgxlnq419s9RR5EEgjRPy9n5heMBvHR8RJVHhEsasmEZDZMMMI92y3Tyi4PbIEZFf9M163oqdLv+5HHcSrFzTWm7Umz3SfrAl/pt8+OktbvZorrPR9hwxHIkHu01xN2dedUREPDsnb6mabpv93smuNXO2G+j4h2rjdm5KYFdLA0u487KtjTRRFfmcv8xu/OAOEYCHDk6UO5zvZyxD8eBmotRpAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Am4wSfgaSMibiFBpj4ClLlfhlxQ3cK4gIn7w+f5wx3M=;
 b=McnrfrMK+M7Ixt0haC4faD+My/KpM2sK+EXGRENMldXyd2+enq2LJ2Jb8SNLXdaKmQUCLEeYiyOp6X/v7tPE5hRSmdMGn8cRPHva3FDqM3yBbGHmH9OkJClOApupQ+eHIkQcipoPu3IhyqRzUojyVzEhF83vYWlGAXVWMPFpHKRrBf5kTsaPb/f+DfTOMvjh/OcF2t+wX51EAquzr1xRzBGLHE6iGjnasu0uC9FlmglZMWr6aPENSaJtRyWnfEHziVO1yWmtEX4SJZjfgFq0mtC2ga9cN/u3f9DXQG3vrHTH34z+BKkF2N/1RAt+vVPI54V6fffTlFo1aEQGihYpiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Am4wSfgaSMibiFBpj4ClLlfhlxQ3cK4gIn7w+f5wx3M=;
 b=QaNZRLadMofefdwmvWrqsqD2l5VsCcLhqG0eWuiecq/UVwfxdNHT9GFa6/pG1iBq2HuzRZ2xUsJ46cpiiYuT15zf05eIBAtf/Foj7c+BmnGXuVoNKhVJwNJs1eG2eN3hy/X/O8s7zlYOBBiAvaZofwMehWiKLTQjMXK9M2nP1Nc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SA1PR13MB4928.namprd13.prod.outlook.com (2603:10b6:806:1a8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Fri, 30 Jun
 2023 13:50:15 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6544.019; Fri, 30 Jun 2023
 13:50:15 +0000
Date: Fri, 30 Jun 2023 15:50:09 +0200
From: Simon Horman <simon.horman@corigine.com>
To: Subash Abhinov Kasiviswanathan <quic_subashab@quicinc.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, corbet@lwn.net, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, andersson@kernel.org,
	quic_jhugo@quicinc.com, Sean Tranchetti <quic_stranche@quicinc.com>
Subject: Re: [PATCH net v2] docs: networking: Update codeaurora references
 for rmnet
Message-ID: <ZJ7dkT6UpVmNR/vC@corigine.com>
References: <1688108686-16363-1-git-send-email-quic_subashab@quicinc.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1688108686-16363-1-git-send-email-quic_subashab@quicinc.com>
X-ClientProxiedBy: AS4P190CA0047.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:656::11) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SA1PR13MB4928:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fe11a3a-e98b-4b5c-3204-08db7970eed3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QAeUHZuAPmB6TcxmrSwwShh+spjfFAS9hnWFxuMTIwOxauX7CUG2s8RF0/MfGtQo5W1Q1Xs1h61pl0htEX9laAYGP+ZN/m5bI0SGps93RT0nhcEjm8ireIUboWv+F4uLTRjU7okar5PwckguVSYa6X5FptCompHCPuS5qeCbINxZCAaedDGmkgP73eDltn1CCTmbz0CHdMHZgwdvWwfBmxnL42LgVQQ/fJAstNiTTWZ/vEOSe6nhZdDyHyZt2msWjebPTADtvPbXLjIAfRyfEff//pzozw2X0gTEfzj8cQm5HN4xV0r3IH6qPJY5JAzdMC7gZ4ewp9Zz2nB+tchfRXSilX2iDwyqC744Qr1iz34WPE9TEd25B4EbFjc0zrr7XS9tRpSwsILNXwzAk6vqYwcnrr0XDZWmHnj73d9tUmuY4Vdt/gUfPdaj3i5p5Cgvp6bhmaucfLHzelOqkjjYcjbb3E1/bgCKnLVQRTdLfFlQGBFgaPttKybqBIaumtqFuhVibgdg3ocNmBictj8m7pHySA8m5FmCKpRLz0ZyigEScuXhlzlZVDRbwYLk6RXWWj9Q8STKMPD4QrZdrV4Sr9DZ0+xVP653hgc4tIC7tsI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(366004)(39840400004)(136003)(451199021)(86362001)(8936002)(8676002)(5660300002)(7416002)(6506007)(44832011)(6486002)(478600001)(66946007)(66556008)(66476007)(6916009)(4326008)(6512007)(41300700001)(316002)(6666004)(186003)(2616005)(2906002)(4744005)(83380400001)(36756003)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FHLxizUK6ZKHCbiXXiOy7UBvWLuthTni4vw1QW8J3ptAhxoqRoceNho6jCtU?=
 =?us-ascii?Q?Ygwpd+yAXPN1NUeZqMJF5c36JMi7twFMqzvvxjsTP1qq4ilSg6zGUn6ZEAiV?=
 =?us-ascii?Q?AvkYl2BD2Uc/9bsIgu5Cot5K6iMt39EM/9m+F2wOpAD5QX3sl6nOiKLumWFB?=
 =?us-ascii?Q?qat6ldcOgJ904NEJNXQ8yChscgOa1Rivkj2YoqbZbfEUnBJVZAWsj1ndfK55?=
 =?us-ascii?Q?ZVkFrVE8FCeh6D+FkJuLcyg9TfXU+iAnVLsPP+0W5x6taCSyZ9oLUa7wPrG8?=
 =?us-ascii?Q?hpot2zl9m5rfbFMUPWbYNgRlAftcYaAWcufoDW9XteFHq5f9pikwbKPK4NOq?=
 =?us-ascii?Q?CiVcBCk079DKd61aUW5RGhXsPYt98jF31fYSX4tQSNB6LlS1FaY5t0zw6VtU?=
 =?us-ascii?Q?AotasmQL43egflKh0U01+gV1lxO21il1lRn4RjPeS/Rum7R93oNX+1MLfVUx?=
 =?us-ascii?Q?lmaRBwVA0tGHHeHLsYUmpUEKqisFM6RJIoIgIdEdpXMYahIhCSO8X+z5vQUg?=
 =?us-ascii?Q?Ga8eL+qZiNnMaanWO1FkicW86Qv5aNEMn4cQ4mg+Wuk0dPmGoooBwRG8AUEe?=
 =?us-ascii?Q?Osw2HfEXhkwuYwYeF1piBXRGLjNz8x6L067tzixyxJ9iIcd3qtdCsk1l4MsN?=
 =?us-ascii?Q?XzfJeEmuoHe1ey6JC/hs82CGsIGdaTL8flBTorsLGobq7u9YlUfbo8hXd6ho?=
 =?us-ascii?Q?iaCOG2o92gyXxAYBCZYBOeXshY4bBF9yMP7fXwktrQIwzlOss1tHSdEJ27tR?=
 =?us-ascii?Q?6py8iVFv0WHP1AmnShWCiLnVXrZqzHdoAiUWqmfRNIkGMoHb3kk+Ic8ki4/Y?=
 =?us-ascii?Q?OK08ZZyR+2ZJuy4u/2kb7b1qzscA/YZVZHhg8JyCsKTw5HnRxItgWGN9bVpL?=
 =?us-ascii?Q?vfaTusOb0iVvU81VrlqgM3o1+dRt8wmXwtM8nLpZ94zPPn3Y1moemNpN2dj5?=
 =?us-ascii?Q?XsUY5w0U3dc16h094VkQZ42BrgL7J8mvxWsJyIKQtX8owq/wYrbKzv5Q7aHg?=
 =?us-ascii?Q?VPZIdxSU/why7JnAfF4yZ5uY/giRGxvFpExhOX+/HXqB+utpxgTTS5Ms/nFJ?=
 =?us-ascii?Q?N0cMxMucyq5kr2tlLdgmK3LVZO00spNc3adtVPfqW7XwGCB0Lmy/nXHSc2j7?=
 =?us-ascii?Q?uta/7xm/T6bPvew2cQ3dMqIdENlGXKVAiFYxAooelXQIRi+rjW0jDUUxGsMh?=
 =?us-ascii?Q?Cxgrt0v9YosCI9G2dJuKRRhPQy1TXKcsT3OMgE/zhZZteK9V7wMfqqZrj6cD?=
 =?us-ascii?Q?gNpqqu+99xfK3qoTYJbRXL/b8ZpSvvSeKVYqKsCoKgL2LDOOI60Zuq4KFlqs?=
 =?us-ascii?Q?FcSijPfwZ5WeB+3FDB7l7iTnYPu1c3Q64uZlOD3QJ3oebyX9Y96sGaWnxYNW?=
 =?us-ascii?Q?QVm73oEO+6BRIqD1gaMlWhtzIsWA2x0aCRiuJQWOK7slyxyIY+cDAPZDe+tE?=
 =?us-ascii?Q?38rqK2E2c5Saf242bM162N2LXuOuVEHPRSOOUfmZ9Kc6GpICdaRBYe6HcQWS?=
 =?us-ascii?Q?eTo1M/uA15cqlc3seSnTyQcjHz5cLGghAdXZXALjX2ZTl1QwfwiC2rN7dozm?=
 =?us-ascii?Q?y3Tzby+Q9IlbsYTiIFoD4bGNyf/Y6WwJit9H34ijIsSYbL56TfBzWRWEdjeh?=
 =?us-ascii?Q?Aub756B09HiAhvHWu+Utb95mOBYxwzbWGGTZNze3kb7fuKxN23zTldm8UDFf?=
 =?us-ascii?Q?dNYAGg=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fe11a3a-e98b-4b5c-3204-08db7970eed3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 13:50:15.4643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9CRuMoNQzjserLsLbJdUUg3OgdqTVbh9sG9M3b5oPnCnsWnLcMBrCE9KjjRjZVhIsTMNgC3YW0W1v6gBHeVbEPDQjiwBvOFJ5v4mJ/C8Zgo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR13MB4928
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 30, 2023 at 01:04:46AM -0600, Subash Abhinov Kasiviswanathan wrote:
> source.codeaurora.org is no longer accessible and so the reference link
> in the documentation is not useful. Use iproute2 instead as it has a
> rmnet module for configuration.
> 
> Fixes: ceed73a2cf4a ("drivers: net: ethernet: qualcomm: rmnet: Initial implementation")
> Signed-off-by: Sean Tranchetti <quic_stranche@quicinc.com>
> Signed-off-by: Subash Abhinov Kasiviswanathan <quic_subashab@quicinc.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>


